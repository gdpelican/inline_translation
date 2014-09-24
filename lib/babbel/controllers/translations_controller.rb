module Babbel
  module Controllers
    module TranslationsController < ApplicationController

      def create
        if Babbel::Models::Translation.create permitted_params
          
        else
        
        end
        @translation = Babbel::Models::Translation.new permitted_params

      end

      protected

      def permitted_params
        
      end

    end
  end
end
