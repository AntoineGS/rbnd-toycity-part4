class Module
  def create_finder_methods(*attributes)
    attributes[0].each do |attribute|
      attribute = attribute.to_s
      attribute[0]=''
      class_eval("def self.find_by_#{attribute}(#{attribute}); all.find{|data| data.#{attribute} == #{attribute}} end")
    end
  end
end
