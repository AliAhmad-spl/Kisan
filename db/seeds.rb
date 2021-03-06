User.delete_all
User.create([{ name: 'Admin User', email: 'admin@kisan.com', password: 'admin123', remember_created_at: nil }])
