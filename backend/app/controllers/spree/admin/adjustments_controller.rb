module Spree
  module Admin
    class AdjustmentsController < ResourceController

      belongs_to 'spree/order', find_by: :number

      create.after :update_totals
      destroy.after :update_totals
      update.after :update_totals

      skip_before_filter :load_resource, only: [:toggle_state, :edit, :update, :destroy]

      before_action :find_adjustment, only: [:destroy, :edit, :update]

      def index
        @adjustments = @order.all_adjustments.order("created_at ASC")
      end

      private

      def find_adjustment
        # Need to assign to @object here to keep ResourceController happy
        @adjustment = @object = parent.all_adjustments.find(params[:id])
      end

      def update_totals
        @order.reload.update!
      end

    end
  end
end
