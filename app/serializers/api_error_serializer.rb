module APIErrorSerializer
  extend Enumerize

  enumerize :messages, in: {
    unprocessable_entity: I18n.t('api.errors.unprocessable_entity'),
    unauthorized:         I18n.t('api.errors.unauthorized')
  }

  def self.serialize(error)
    return if error.nil?

    { errors: { params: messages.find_value(error).value } }
  end

end
