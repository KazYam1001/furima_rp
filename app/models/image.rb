class Image < ApplicationRecord

  belongs_to :item

  mount_uploaders :src, ImageUploader
end
