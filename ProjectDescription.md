# L.EIC012: Bases de Dados — Database Project 25/26

This project offers students hands-on experience in designing and implementing a relational database using SQLite. The project spans several phases, starting with creating a conceptual model for a chosen topic, then developing a relational schema, and ultimately, the implementation and population of the database. Additionally, students will use generative AI tools to support various stages of the database development process.

## 1. Important Dates

- Working Group Definition: September 28, 11:55 PM
- Problem Domain Definition: October 5, 11:55 PM
- First Submission: October 19, 11:55 PM
- Second Submission: November 23, 11:55 PM

## 2. Working Group Definition

Students will work in teams of three. Group setup must be completed using the "Groups for the project" activity in Moodle. The first digits of each group's identifier must correspond to the class number. For instance, Group 0101 should consist of students from class 2LEIC01 and Group 1201 of students from 2LEIC12.

## 3. Problem Domain Definition

Groups shall propose a project topic related to database implementation, which must be approved by the professor of the theoretical-practical classes. Once the topic is approved, the group must submit a 100-word description through Moodle. This description should specify a potential application that could use the database and the information the database will contain (expected entities, their attributes, and how they relate to each other).

For your reference, we expect relational schemas with 10 to 15 relations, with some of these relations featuring composite keys.

## 4. First Submission: Conceptual Modelling

In this submission, students will focus on the initial stages of database development, including conceptual model design and generative AI integration for this task.

### 4.1 Tasks

- **4.1.1 Domain Definition.** Familiarise yourself with the context associated with the topic of the work. Understand in detail the data that the database must store.
- **4.1.2 Initial Conceptual Modelling.** Define a conceptual model in UML for a database for the defined problem domain without using generative AI.
- **4.1.3 Generative AI Integration.** Use a generative AI tool to assist in conceptual modelling for your topic. You may either: (1) generate a conceptual model from scratch and compare it with the one created in the previous stage, or (2) provide your initial model to the AI tool and use its feedback for refinement in the next stage.
- **4.1.4 Final Conceptual Modelling.** Propose a final solution for the conceptual model based on your initial conceptual model and generative AI assistance.

### 4.2 Report

A report in PDF format with the following sections.

1. Context description (Task 4.1.1). A maximum 500-word explanation of the project domain and data requirements. Include all information that may be important for evaluating the conceptual model. This description *should not* be a description of the conceptual model.
2. Initial Concept Model (Task 4.1.2). Include the UML diagram and indicate constraints, associations, multiplicities and derived elements if applicable.
3. Generative AI Integration (Task 4.1.3). Document the AI tools used, the sequence of prompts, and critically assess the results.
4. Final Concept Model (Task 4.1.4). Discuss the refinements made based on AI support.

## 5. Second Submission: Relational Modelling, Database Creation and Data Population

### 5.1 Tasks

- **5.1.1 Refine the Conceptual Model.** Refine the conceptual model based on the feedback you received for the first submission.
- **5.1.2 Initial Relational Schema.** Without using generative AI, manually convert the refined conceptual model into a relational schema, which should be added to the report in a textual format using the syntax: "R1 (atr1, atr2, atr3->R2)". A clear indication of each relation's primary and foreign keys is expected. Other constraints are optional.
- **5.1.3 Generative AI Integration.** Use a generative AI tool to collect insights or suggestions that will assist in developing the final relational schema.
- **5.1.4 Final Relational Schema.** Propose a final schema after incorporating AI feedback.
- **5.1.5 Initial Analysis of Functional Dependencies and Normal Forms.** Without using AI, for each relation, identify functional dependencies and analyse violations of Boyce-Codd Normal Form and 3rd Normal Form. Students must justify the non-existence of violations. Decompose relations that are neither in the Boyce-Codd Normal Form nor the 3rd Normal Form.
- **5.1.6 Generative AI Integration.** Use a generative AI tool to assist in Task 5.1.7.
- **5.1.7 Final Analysis of Functional Dependencies and Normal Forms.** Present a refined analysis after AI assistance.
- **5.1.8 Initial SQLite Database Creation.** Without using generative AI:
  - Write a file named `create1.sql` that includes the SQL statements to create all the relations of the final relational schema designed in Task 5.1.4 (or after Task 5.1.7, if decomposition has occurred). Before creating the tables, make sure to drop existing relations with the same name. SQLite allows you to read commands from a file. This feature should be used to (re)create the database whenever necessary.
  - For each constraint identified in the refined conceptual model, decide how it should be implemented in SQL and update the `create1.sql` file to include the SQL statements that implement the constraints. Note that some constraints might require triggers and, in these cases, should not be implemented. It is also necessary to consider that implementing constraints in SQLite is not fully compliant with the SQL-99 (SQL2) standard.
- **5.1.9 Generative AI Integration.** Use a generative AI tool to assist in Task 5.1.10.
- **5.1.10 Final SQLite Database Creation.** Propose a final solution for the SQLite database creation in a `create2.sql` script based on AI feedback.
- **5.1.11 Initial Data Loading.** Create a file named `populate1.sql` that includes the SQL statements to introduce data in all previously created tables. At the beginning of this file, you must have the statement `PRAGMA foreign_keys = ON;` to ensure that the referential integrity check of the database is active.
- **5.1.12 Generative AI Integration.** Use a generative AI tool to assist in Task 5.1.13.
- **5.1.13 Final Data Loading.** Propose a final version of the data loading script — `populate2.sql` — based on your `populate1.sql` script and generative AI assistance.

### 5.2 Report

A report in PDF format with the following sections.

1. Refined Conceptual Model (Task 5.1.1). The refined model should be included in the report even if no changes are needed.
2. Relational Schema. Including three subsections:
   1. Initial proposal with the output of Task 5.1.2.
   2. Generative AI assistance providing a clear description of the specific generative AI tool used and the sequence of prompts given to the tool.
   3. Final proposal with the output of Task 5.1.4 and the list of refinements made after AI assistance.
3. Functional Dependencies and Normal Forms Analysis. Including three subsections:
   1. Initial proposal with the output of Task 5.1.5.
   2. Generative AI assistance providing a clear description of the specific generative AI tool used and the sequence of prompts given to the tool.
   3. Final proposal with the output of Task 5.1.7 and the list of refinements made after AI assistance.
4. SQLite Database Creation. Provide a clear description of the specific generative AI tool used and the sequence of prompts given to the tool. Discuss the refinements made after AI tool integration.
5. Data Loading. Provide a clear description of the specific generative AI tool used and the sequence of prompts given to the tool. Discuss the refinements made after AI tool integration.
6. Generative AI integration. Critically assess the output generated by the AI tool throughout the project, highlighting strengths and limitations. In which stage was the AI tool more useful and why? In which stage was the AI tool less useful, and why?

### 5.3 Other Deliverables

Students should also submit the `create1.sql`, `create2.sql`, `populate1.sql` and `populate2.sql` scripts.

## 6. Evaluation

The overall grade of the project will be computed as: 0.4 × 1st submission grade + 0.6 × 2nd submission grade.
