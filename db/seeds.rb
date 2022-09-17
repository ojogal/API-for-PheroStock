CompanyChemical.delete_all
Chemical.delete_all
Company.delete_all
User.delete_all

6.times do
  user = User.create! email: Faker::Internet.email, password: 'onetwo34'
  puts "Created a new user: #{user.email}, #{user.id}"

    1.times do
      company = Company.create!(
      company_name: Faker::Company.name,
      user_id: user.id
      )
      puts "Created a brand new company: #{company.company_name}"
      
      3.times do
        chemical = Chemical.create!(
        chemical_name: Faker::Company.name,
        synonym: Faker::Company.suffix,
        cas: Faker::Company.ein,
        user_id: user.id,
        )
        chemical.companies << [company]
        puts "Created a brand new chemical: #{chemical.chemical_name}"
      end
    end
end