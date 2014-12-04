require "has_many_commas/version"

module HasManyCommas
  def to_csv(query, association)
    max = 0
    metadata = get_model_metadata(query.model, association)
    rows = 
      query.includes(association).map do |model|
        assoc_count = model.send(association).size
        max = assoc_count if assoc_count > max
        model.attributes.values + 
          model.send(association).map(&:attributes).map(&:values).flatten
      end
    assoc_headers = 
      max.times.map do |i|
        metadata[:assoc_header_names].map do |name|
          "#{ metadata[:assoc_name] }_#{ i + 1 }_#{ name }"
        end
      end.flatten
    [metadata[:model_headers] + assoc_headers] + rows
  end

  def get_model_metadata(m, assoc)
    m_name = snake_case_class_name(m.name)
    a = m.reflect_on_all_associations.find{|x|x.name == assoc}.klass
    a_name = snake_case_class_name(a.name)
    {
      model_name: m_name,
      model_headers: m.columns.map(&:name).map{|attr| "#{m_name}_#{attr}"},
      assoc_header_names: a.columns.map(&:name),
      assoc_name: a_name
    }
  end

  def snake_case_class_name(str)
    str.delete(?:).underscore
  end
end
