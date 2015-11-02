json.array!(@testimonials) do |testimonial|
  json.extract! testimonial, :id
  json.url testimonial_url(testimonial, format: :json)
end
