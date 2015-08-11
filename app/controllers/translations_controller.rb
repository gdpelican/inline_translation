module InlineTranslation
  module Controllers
    class TranslationsController < ::ApplicationController
      respond_to :js, :json

      def create
        if service.translate(translatable, to: to_language)
          @translations = translatable.translations.where(language: to_language)
          respond_to do |format|
            format.js { render :create }
            format.json { render json: @translations } # TODO: support for AMS / custom serialization
          end
        else
          failure_response
        end
      end

      private

      def failure_response
        head :unprocessable_entity
      end

      def self.controller_path
        :translations
      end

      def service
        @service ||= InlineTranslation::Services::TranslationService.new
      end

      def translatable
        @translatable ||= params[:translatable_type].classify.constantize.get_instance params[:translatable_id] rescue nil
      end

      def to_language
        params[:to] || I18n.locale
      end

    end
  end
end
