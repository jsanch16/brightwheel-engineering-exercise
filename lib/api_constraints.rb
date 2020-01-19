class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  # Checks if the version matches the 'Accept' header
  #
  # @param req [ActionDispatch::Request] request received
  # @return [Boolean]
  def matches?(req)
    @default || (req.try(:headers).try(:[],'Accept') &&
      req.headers['Accept'].include?("application/api.brightwheel.v#{@version}"))
  end
end