class Student
  include Mongoid::Document
  field :name, type: String
  field :marks, type: Array

  def self.store_students
    (1..100).each do |st|
      m_ary = []
      (1..6).each do |m|
        m_ary.push((0..100).to_a.sample)
      end
      puts m_ary.inspect
      Student.create(name: Faker::Name.name, marks: m_ary)
    end
  end
end
