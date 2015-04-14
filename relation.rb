class Relation
  
  attr_accessor :person, :related_to, :relation
  
  def initialize(person, related_to, relation)
    @person = person
    @related_to = related_to
    @relation = relation
  end
  
  def self.find_by_person( person )
    all.select{|r| r.person.name == person.name}
  end
  
  def self.find_by_related_to( person )
    all.select{|r| r.related_to.name == person.name}
  end
  
  
  def self.all
    YAML.load_file('family_relation.yml').each{ |person,v|
      v.map do |related_to, relation|
        Relation.initialize( Person.find_by_name( person ), Person.find_by_name( related_to ), relation)
      end  
    }.flatten
  end
  
  def self.population_relation_yml
    
  end
end