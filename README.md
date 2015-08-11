# Inline Translation

`inline_translation` is a gem which provides your application with a simple, easy-to-use way to perform inline translations of content, into a variety of languages.

It's written as a wrapper for the fine [bing_translator gem](https://github.com/relrod/bing_translator-gem), but can be easily extended to using other translation services.

## Demo

Check out the example app [here](http://inline-translation-test.herokuapp.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inline_translation'
```

And then execute:

    $ bundle

Then, execute the install generator

    $ rails g inline_translation:install

And migrate

    $ rake db:migrate

Now you're all set up!

## Usage

Inline Translation supplies several helper methods to make your translating life easier.

To mark a field on an object as translatable, simply add

`acts_as_translatable, on: :field_name`

to your model.

#### Additional options

- **load_via** - the class method used to find a record for your model. Defaults to `:find`
- **id_field** - field name for the unique identifier for your model. Defaults to `:id`
- **language_field** - field name for the method / column name on your model to retrieve the language. Defaults to `language`

NB: Oftentimes, you may wish to delegate this method to a user or other object, instead of storing the language on every model.

For example:

```ruby
# model.rb
class Model < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  acts_as_translatable on: :column

  def language
    author.locale
  end
end
```

## On the frontend

#### The translation link

InlineTranslation provides a simple helper method for translation links in the view.

For example, adding

```ruby
translate_link_for(@model, to: :fr)
```

Will add an ajax link to create and store a French translation. The `to` field will default to I18n.locale.

###### Additional options

- **text** - The text of the anchor generated. Defaults to 'Translate'
- **to** - The language to translate to with this link. Defaults to I18n.locale

(NB: This link will not appear if `@model.language` is equal to the 'to' parameter, since we cannot perform translations to the same language.)

#### Populating the translation (via UJS)

The simplest possible markup for including translations on callback:

```ruby
# /app/views/models/show.html.erb
<div id="model-1">
  <%= translated_element_for @model, :field_a %>
  <%= translated_element_for @model, :field_b %>
</div>
```

(Note that this markup can occur anywhere, as long as the `translated_element_for` elements are within a div of the format 'className-id')

If this particular markup structure doesn't work for you for whatever reason, feel free to edit the `app/views/translations/create.js.erb` with javascript to your liking.

###### Additional options

- **element** - The type of element generated. Defaults to 'span'

#### Populating the translation (via JSON)

The `translations#create` action can also accept a `:json` format, which will return a list of serialized translations. These can be consumed by your javascript frontend framework as you see fit.
(TODO: provide more robust support for custom serialization, such as through ActiveModel::Serializers PRs welcome!)

ie, a simplistic implementation in angular:

```html
<!--in the view -->
<a href='' ng-click='translateToFrench()'>Translate</a>
```

```javascript
// in the controller
$scope.translateToFrench = function() {
  $http.post('/translations', { translatable_id: 1, translatable_type: 'Model', to: 'fr', format: 'json'}).then(function(data) {
    $scope.frenchTranslation = data
  })
}
```


## On the backend

InlineTranslation uses the Bing Translator API as a default. For instructions on setting up the Bing Translator API, [go here](https://github.com/relrod/bing_translator-gem#getting-a-client-id-and-secret).

## Different Translators

Simply change the line in `config/initializers/inline_translation.rb` to use whatever translator you desire.

Note that a custom translator must implement the following methods:

- `self.ready?`: Returns true if the translator can translate anything
- `can_translate?`: Returns true the translator can translate the given translatable
- `translate`: Returns a translation for all `acts_as_translatable` fields on the translatable

## Contributing

1. Fork it ( https://github.com/[my-github-username]/inline_translation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
