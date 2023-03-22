require 'csv'

def generate_password(input_value)
  alphabets = ('a'..'z').to_a + ('A'..'Z').to_a
  numerics = (0..9).to_a.map(&:to_s)
  special_chars = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '[', ']', '{', '}', '|', ';', ':', '<', '>', '.', '?', '/']
  chars = []

  if input_value.keys == ['alphabets']
    chars += alphabets
  end

  if input_value.keys == ['numbers']
    chars += numerics
  end

  if input_value.keys == ['symbols']
    chars += special_chars
  end

  password = ""
  input_value.values[0].times do
    password += chars.sample
  end

  return password
end

def store_in_CSV(result, csv_file_path)
  CSV.open(csv_file_path, "a") do |csv|
    csv << [result]
  end
end

input = "numbers = 10"
csv_file_path = "passwords.csv"

generated_hash = {input.split("=")[0].strip => input.split("=")[1].to_i}

password = generate_password(generated_hash)

password_exists = false

CSV.foreach(csv_file_path) do |row|
  passwords = row[0]
  if passwords.include? password
     password_exists = true
     break
  end
end

if !password_exists
  store_in_CSV(password, csv_file_path)
end
