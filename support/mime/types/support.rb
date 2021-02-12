# frozen_string_literal: true

require 'mime/types'

# We are an internal tool. Silence deprecation warnings.
class MIME::Types
  def self.deprecated(*_args, &_block); end
end
