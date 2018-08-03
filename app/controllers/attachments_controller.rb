class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.article_id = params[:article_id]

    if @attachment.save
      flash[:notice] = "Attachment '#{@attachment.image_file_name}' Successfully created!"
    else
      flash[:alert] = "Error creating new attachment!"
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:author_name, :body)
  end

end
