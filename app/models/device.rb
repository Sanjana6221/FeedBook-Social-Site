class Device < ApplicationRecord
	scope :android, -> { where(device_type: 'android') }
end
