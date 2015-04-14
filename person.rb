class Person
  attr_accessor :name, :gender
  
  
  def initialize(name, gender)
    @name = name
    @gender = gender
  end
  
  def relations
    Relation.find_by_person( person )
  end
  
  def related_to_person
    Relation.find_by_related_to( person )
  end
  
  def parents
    relations.select{|r| r.relation == "parent"}
  end
  
  def father
    parents.select{|r| related_to.gender == "m"}.last.try(:person)
  end
  
  def mother
    parents.select{|r| related_to.gender == "f"}.last.try(:person)
  end
  
  
  def children
    related_to_person.select{|r| r.relation == "parent"}.map{|r| r.person }
  end

  
  def brothers
    father.children
  end
  
  def self.find_by_name( name )
    Person.all.select{|person| person.name == name}.last
  end
  
  
  
  def self.all 
    YAML.load_file('shan_family.yml').map{|name, gender| Person.initialize(name, gender)}
  end
end