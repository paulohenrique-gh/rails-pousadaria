class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  ALLOWED_FILE_TYPES = ['image/jpeg', 'image/png']

  protected

  def file_format_must_be_jpeg_or_png
    if self.pictures.attached?
      new_files = self.pictures.select { |file| file.new_record? }

      new_files.each do |file|
        unless file.content_type.in?(ALLOWED_FILE_TYPES)
          self.errors.add(:pictures, 'devem ser em formato JPEG ou PNG')
        end
      end
    end
  end
end
