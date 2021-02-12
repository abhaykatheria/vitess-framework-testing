namespace :guide_association do
	task :step_1 do
		@author = Author.create(name: "Somebody")
		@book = @author.book2s.create(title: "Epic Novel")
		@author.destroy
		# TODO:  Issue a bare SQL query to ensure that Somebody and Epic Novel are both gone from the database
	end

	task :step_2_1 do
		# Yes this is functionally the same as :step_1
		author = Author.create(name: "Somebody2")
		book = author.book2s.create(title: "Epic Novel 2")
		author.destroy
		# TODO:  Issue a bare SQL query to ensure that Somebody and Epic Novel are both gone from the database
	end

	task :step_2_2 do
		supplier = Supplier.create!(name: "Products Inc")
		account = Account2.create!(supplier: supplier, account_number: "1234")
		supplier.save!
	end

	task :step_2_3 do
		# Yes this is functionally the same as :step_1 and :step_2_1
		author = Author.create!(name: "Somebody3")
		book = author.book2s.create!(title: "Epic Novel 3")
		author.destroy
		# TODO:  Issue a bare SQL query to ensure that Somebody and Epic Novel are both gone from the database
	end

	task :step_2_4 do
		doc = Physician.create!(name: "Dr Mario")
		patient = Patient.create!(name: "Me")
		appointment = Appointment.create!(physician: doc, patient: patient, appointment_date: Date.today)
		patient2 = Patient.create!(name: "You")
		appointment2 = Appointment.create!(physician: doc, patient: patient2, appointment_date: Date.today)
		raise "wrong patients" unless doc.patients == [patient, patient2]
	end

	task :step_2_5 do
		supplier = Supplier.create!(name: "Products Inc")
		account = Account2.create!(supplier: supplier, account_number: "1234")
		history = AccountHistory.create!(account2: account, credit_rating: 1000)
		supplier.save!
	end

	task :step_2_6 do
		p1 = Part.create!(part_number: "1")
		p2 = Part.create!(part_number: "2")
		p3 = Part.create!(part_number: "3")
		a1 = Assembly.create!(name: "a")
		a2 = Assembly.create!(name: "b")
		a1.parts = [p1, p2, p3]
		a1.save!
		p2.assemblies += [a2]
		p2.save!
		a2.parts += [p3]
		a2.save!
		raise "p1 assemblies wrong" unless p1.assemblies == [a1]
		raise "p2 assemblies wrong" unless p2.assemblies == [a1, a2]
		raise "p3 assemblies wrong" unless p3.assemblies == [a1, a2]
		raise "a1 parts wrong" unless a1.parts == [p1, p2, p3]
		raise "a2 parts wrong" unless a2.parts == [p2, p3]
	end

	task :step_2_7 do
		supplier = Supplier2.create!(name: "Widgetcorp")
		account = Account3.create!(supplier2: supplier)
	end

	task :step_2_8 do
		p1 = Part2.create!()
		p2 = Part2.create!()
		p3 = Part2.create!()
		a1 = Assembly2.create!()
		a2 = Assembly2.create!()
		a1.part2s = [p1, p2, p3]
		a1.save!
		p2.assembly2s += [a2]
		p2.save!
		a2.part2s += [p3]
		a2.save!
		raise "p1 assemblies wrong" unless p1.assembly2s == [a1]
		raise "p2 assemblies wrong" unless p2.assembly2s == [a1, a2]
		raise "p3 assemblies wrong" unless p3.assembly2s == [a1, a2]
		raise "a1 parts wrong" unless a1.part2s == [p1, p2, p3]
		raise "a2 parts wrong" unless a2.part2s == [p2, p3]

		p1 = Part3.create!()
		p2 = Part3.create!()
		p3 = Part3.create!()
		a1 = Assembly3.create!()
		a2 = Assembly3.create!()
		a1.part3s = [p1, p2, p3]
		a1.save!
		p2.assembly3s += [a2]
		p2.save!
		a2.part3s += [p3]
		a2.save!
		raise "p1 assemblies wrong" unless p1.assembly3s == [a1]
		raise "p2 assemblies wrong" unless p2.assembly3s == [a1, a2]
		raise "p3 assemblies wrong" unless p3.assembly3s == [a1, a2]
		raise "a1 parts wrong" unless a1.part3s == [p1, p2, p3]
		raise "a2 parts wrong" unless a2.part3s == [p2, p3]
	end

	task :step_2_9 do
		employee1 = Employee.create!(name: "Me")
		employee2 = Employee.create!(name: "You")
		product = Product.create!(name: "Thing")
		pic1 = Picture.create!(name: "My Photo", imageable: employee1)
		pic2 = Picture.create!(name: "Your Photo", imageable: employee2)
		pic3 = Picture.create!(name: "Product Photo", imageable: product)
	end

	task :step_2_10 do
		e1 = Employee2.create!(name: "CEO")
		e2 = Employee2.create!(name: "CTO", manager: e1)
		e3 = Employee2.create!(name: "VP Dev", manager: e2)
		e4 = Employee2.create!(name: "VP Product", manager: e2)
		e5 = Employee2.create!(name: "Manager Dev", manager: e4)
		e6 = Employee2.create!(name: "Dev 1", manager: e5)
		e7 = Employee2.create!(name: "Dev 2", manager: e5)
	end
end

