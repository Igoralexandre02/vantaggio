class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: %i[show edit update destroy]

  def index
    @q = <%= class_name %>.ransack(params[:q])
    @pagy, @<%= plural_table_name %> = pagy(@q.result)
  end

  def show
  end

  def new
    @<%= singular_table_name %> = <%= class_name %>.new
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= class_name %>.new(<%= singular_table_name %>_params)

    if @<%= singular_table_name %>.save
      redirect_to <%= plural_table_name %>_path, notice: t("messages.created_successfully")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
      redirect_to <%= plural_table_name %>_path, notice: t("messages.updated_successfully"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @<%= singular_table_name %>.destroy
      redirect_to <%= plural_table_name %>_url, notice: t("messages.deleted_successfully")
    else
      redirect_to <%= plural_table_name %>_url, alert: t("messages.delete_failed_due_to_dependencies")
    end
  end

  private

  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= class_name %>.find_by(id: params[:id])
    redirect_to <%= plural_table_name %>_path, alert: t("messages.not_found") unless @<%= singular_table_name %>
  end

  def <%= singular_table_name %>_params
    unpermitted = %w[id deleted_at created_by updated_by]
    permitted = <%= class_name %>.column_names.reject { |col| unpermitted.include?(col) }
    params.require(:<%= singular_table_name %>).permit(permitted.map(&:to_sym))
  end
end
