# Inclusion and sparse fields support
module JSONAPI::Fetching
  private

  # Extracts and formats sparse fieldsets
  #
  # Ex.: `GET /resource?fields[relationship]=id,created_at`
  #
  # @return [Hash]
  def jsonapi_fields
    ActiveSupport::HashWithIndifferentAccess.new.tap do |h|
      (params[:fields] || []).each do |k, v|
        h[k] = v.split(',').map(&:strip).compact
      end
    end
  end

  # Extracts and whitelists allowed includes
  #
  # Ex.: `GET /resource?include=relationship,relationship.subrelationship`
  #
  # @return [Array]
  def jsonapi_include
    params['include'].to_s.split(',').map(&:strip).compact
  end
end