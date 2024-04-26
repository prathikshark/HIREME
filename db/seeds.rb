# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

u1 = User.create(name: "admin1", email: "admin1@hireme.com", password: "admin1", isadmin: true,role: 2)
u2 = User.create(name: "admin2", email: "admin2@hireme.com", password: "admin2", isadmin: true,role: 2)

s1=Skill.create(skill_type:"cooking")
s1=Skill.create(skill_type:"Maid")
s1=Skill.create(skill_type:"care taking")
s1=Skill.create(skill_type:"driving")

