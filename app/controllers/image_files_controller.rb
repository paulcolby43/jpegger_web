class ImageFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image_file, only: [:show, :edit, :update, :destroy]
#  load_and_authorize_resource

  # GET /image_files
  # GET /image_files.json
  def index
    @image_files = current_user.image_files
  end

  # GET /image_files/1
  # GET /image_files/1.json
  def show
    @ticket_number = @image_file.ticket_number
  end

  # GET /image_files/new
  def new
    @image_file = ImageFile.new
  end

  # GET /image_files/1/edit
  def edit
  end

  # POST /image_files
  # POST /image_files.json
  def create
    require 'open3'
    respond_to do |format|
      format.html { 
        @image_file = ImageFile.new(image_file_params)
        if @image_file.save
          flash[:image_file_id] = @image_file.id
          flash[:notice] = 'Image was successfully created and is being saved by JPEGger.' 
          redirect_back fallback_location: root_path
#          redirect_to root_path(image_file_id: @image_file.id)
        else
          render :new
        end
        }
      format.json { 
        @image_file = ImageFile.new(image_file_params)
        if @image_file.save
          render :show, status: :created, location: @image_file 
        else
          render json: @image_file.errors, status: :unprocessable_entity
        end
        }
      format.js {
        @image_file = ImageFile.create(image_file_params)
      }
    end
  end

  # PATCH/PUT /image_files/1
  # PATCH/PUT /image_files/1.json
  def update
    respond_to do |format|
      if @image_file.update(image_file_params)
        format.html { redirect_to @image_file, notice: 'Image file was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_file }
      else
        format.html { render :edit }
        format.json { render json: @image_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_files/1
  # DELETE /image_files/1.json
  def destroy
    @image_file.destroy
    respond_to do |format|
      format.html { redirect_to image_files_url, notice: 'Image file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_file
      @image_file = ImageFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_file_params
      # order matters here in that to have access to model attributes in uploader methods, they need to show up before the file param in this permitted_params list 
      params.require(:image_file).permit(:ticket_number, :name, :file, :user_id, :customer_number, :customer_name, :branch_code, :location, :event_code, :event_code_id, 
        :image_id, :container_number, :booking_number, :contract_number, :hidden, :blob_id, :tare_seq_nbr, :commodity_name, :weight, :vin_number, :tag_number, 
        :yard_id, :contract_verbiage, :service_request_number, :container_id, :task_id)
    end
end