# frozen_string_literal: true

# Main helpers, provides presenters.
module ApplicationHelper
  def present(presenter_class, local_assigns = nil)
    return unless presenter_class
    klass = "#{presenter_class}Presenter"
    presenter = klass.constantize.new(local_assigns)
    yield(presenter) if block_given?
    presenter
  end
end
