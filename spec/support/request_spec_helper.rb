# Helper methods to use in request specs
module RequestSpecHelper
  # Returns a hash of the v1 accept header to use in request spec endpoint calls
  #
  # @return [Hash] the v1 accept header
  def v1_header
    { 'Accept' => 'application/api.brightwheel.v1' }
  end

  # Returns a JSON parsed hash of the reponse from a test request endpoint call
  # hash values are returned as symbols for easier use in ruby
  #
  # @return [JSON] the v1 accept header
  def json
    JSON.parse(response.body, symbolize_names: true)
  end
end
