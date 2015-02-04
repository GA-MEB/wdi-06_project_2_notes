require 'pry'
require 'csv'

def set_up_scorecards
  students = CSV.read("students.csv", {headers: true}).map{ |row|
    { :first => row[0],
      :last => row[1],
      :github => row[2],
      :email => row[3]
    }
  }

  students.each do |student|
    puts "Creating file for #{student[:first]} #{student[:last]}"
    File.open("student_scorecards/#{student[:first].downcase}_#{student[:last].downcase}.md", 'w') {|f|
      f.write(
        "# Scorecard for : #{student[:first]} #{student[:last]}\n"+
        "### [GitHub Account](www.github.com/#{student[:github]})\n"+
        "### Heroku URL for App: \n"+
        "### Link to Other Materials:\n"+
        "\n" +
        "#{planning_template}\n"+
        "#{execution_template}\n"+
        "#{finished_product_template}\n"+
        "#{summary_template}"
      )
    }
  end
end

# Text Templates
def planning_template
  "## 1 - Planning (observations made on day 1)\n" +
  [{category: "Project Scope/Complexity",
    questions:"Was the project plan too ambitious? Too easy? Did the student stretch themselves?"},
   {category: "Specification",
    questions: "Did the student put together a project summary? User stories? Wireframes? Did they map out their model relationships?"},
   {category: "Solution Architecture",
    questions: "Does the student's planned solution make sense for this problem? Have they chosen reasonable models and model relationships?"},
   {category: "Team Organization (Project 2 Only)",
    questions: "Was a plan set in place for effective team communication and collaboration during the project?"},
   {category: "Collaboration (Project 2 Only)",
    questions: "Did the student work well with others during the planning process?"}
  ].map{|category_hash|
    "#### #{category_hash[:category]}\n\t*#{category_hash[:questions]}*\n#{instructor_notes_partial}\n"
  }.join
end
def execution_template
  "## 2 - Execution (observations made during project work time)\n" +
  [{category: "Version Control",
    questions: "Is the student using version control effectively? Are they making regular commits, with clear commit messages? Are they avoiding making commits directly to their master branch?"},
   {category: "Testing",
    questions: "Is the student writing acceptance tests before they build new features? Are unit tests being written to test standalone components? Are the tests written correctly?"},
   {category: "Independence",
    questions: "Is the student effectively answering their own questions and resolving their own issues?"},
   {category: "Collaboration (Project 2 Only)",
    questions: "Is the student working effectively with others in their group? Are they pulling their weight vis-a-vis the group?"}
  ].map{|category_hash|
    "#### #{category_hash[:category]}\n\t*#{category_hash[:questions]}*\n#{instructor_notes_partial}\n"
  }.join
end
def finished_product_template
  "## 3 - Finished Product (observations made during and after presentation)\n" +
  [{category: "Presentation",
    questions: "Is the student's presentation clear? Does it effectively explain the purpose for the application and how it is used? Does the student effectively defend the decisions that have been made?"},
   {category: "Functionality",
    questions: "Does the application work when it is demonstrated? How rubust is it?"},
   {category: "Meets Project-Specific Requirements",
    questions: "Has the student met any special requirements for this particular project? (e.g. must be deployed to Heroku, must incorporate an external API)"},
   {category: "Code - Structure",
    questions: "Does the code follow good design guidelines like SRP and DRY? Are methods/functions small and modular? Is there code smell?"},
   {category: "Code - Syntax & Formatting",
    questions: "Is the code clear and readable? Does it use good naming conventions? Is the level of commenting appropriate, too sparse, or excessive?"},
   {category: "Collaboration (Project 2 Only)",
    questions: "Has the student contributed meaningfully to the success of the group?"}
  ].map{|category_hash|
    "#### #{category_hash[:category]}\n\t*#{category_hash[:questions]}*\n#{instructor_notes_partial}\n"
  }.join
end
def summary_template
  "## 4 - SUMMARY\n" +
  [ "Three Biggest Strengths",
    "Three Biggest Weaknesses",
    "Other Notes"
  ].map{|category|
    "#### #{category}\n#{instructor_notes_partial}\n"
  }.join
end
def instructor_notes_partial
  "\t Anna:\n\t David:\n\t Jeff:\n\t Tom:"
end

set_up_scorecards
