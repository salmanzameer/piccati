namespace :plan do
  desc "Create Plans in DB"
  task create: :environment do
    count = Plan.count
    plans = [
      {name: 'Standard', storage: 15, connects: 3},
      {name: 'Executive', storage: 75, connects: 15},
      {name: 'Premium', storage: 150, connects: 30},
      {name: 'Default', storage: 5, connects: 1}
    ]
    plans.each do |plan|
      Plan.create(plan) unless Plan.where(name: plan[:name]).present?
    end
    if count < Plan.count
      puts "#{(Plan.count - count)} new plans created"
    end
  end
end

Rake::Task['db:migrate'].enhance(['plan:create'])