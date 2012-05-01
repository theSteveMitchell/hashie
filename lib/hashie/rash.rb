require 'hashie/mash'

module Hashie
  # Rash is a Mash that tracks changes.
  class Rash < Mash
    include Hashie::Extensions::TrackChanges
  end
end

