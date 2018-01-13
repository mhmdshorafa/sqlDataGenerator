BEGIN;


CREATE TABLE IF NOT EXISTS user_type (
         id SERIAL PRIMARY KEY,
         name varchar(50),
         created_at timeStamp,
         updated_at timeStamp NULL
       );
       CREATE TABLE IF NOT EXISTS users (
         id SERIAL PRIMARY KEY,
         user_name varchar(50) UNIQUE,
         password varchar(100),
         phone varchar(50),
         user_type integer REFERENCES user_type(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         add_file  integer DEFAULT 0,
         defalt_language varchar(2) DEFAULT 'he',
         created_at timeStamp,
         updated_at timeStamp NULL,
         created_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         updated_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS shabeeba (
         id serial PRIMARY KEY,
         user_id integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         area_name varchar(100),
         image_path varchar(255) DEFAULT NULL,
         email varchar(100) UNIQUE,
         show_evaluation integer,
         created_at timeStamp,
         updated_at timeStamp NULL,
         created_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         updated_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS questions (
         id serial PRIMARY KEY,
         question varchar(255),
         shabeeba_id integer REFERENCES shabeeba(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         created_at timeStamp,
         updated_at timeStamp NULL,
         created_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         updated_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS shabeeba_pages (
           id serial PRIMARY KEY,
           page_name varchar(100),
          created_at timeStamp,
          updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS limited_admin (
         id serial PRIMARY KEY,
         user_id integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         shabeeba_id integer REFERENCES shabeeba(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         email varchar(100) UNIQUE,
         created_at timeStamp,
         updated_at timeStamp NULL,
         created_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         updated_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS limited_admin_privileges (
         id serial PRIMARY KEY,
         limited_admin_id integer REFERENCES limited_admin(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         page_id integer REFERENCES shabeeba_pages(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         allow_read integer DEFAULT 1,
         allow_create integer DEFAULT 0,
         allow_update integer DEFAULT 0,
         allow_delete integer DEFAULT 0,
         created_at timeStamp,
         updated_at timeStamp NULL,
         created_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         updated_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS company (
          id serial PRIMARY KEY,
          user_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          name varchar(100) UNIQUE,
          logo varchar(100),
          address varchar(100),
          email varchar(100),
          created_at timeStamp,
          updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
        );
        CREATE TABLE IF NOT EXISTS trainers (
         id serial PRIMARY KEY,
         company_id integer REFERENCES company(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         last_seen timeStamp,
         user_id integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         email varchar(100),
         major varchar(100),
         adress varchar(255),
         image_path varchar(255),
         allow_upload integer,
         allow_reg_type integer,
         created_at timeStamp,
         updated_at timeStamp NULL,
         created_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE,
         updated_by integer REFERENCES users(id)
         ON UPDATE CASCADE ON DELETE CASCADE
       );
       CREATE TABLE IF NOT EXISTS school_level (
        id serial PRIMARY KEY,
      	level_name varchar(50) UNIQUE,
      	created_at timeStamp,
      	updated_at timeStamp NULL
    );
       CREATE TABLE IF NOT EXISTS school_sector (
        id serial PRIMARY KEY,
      	sector_name varchar(50) UNIQUE,
      	created_at timeStamp,
      	updated_at timeStamp NULL,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
    );
    CREATE TABLE IF NOT EXISTS schools (
        id serial PRIMARY KEY,
        name varchar(100),
        level integer REFERENCES school_level(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        logo varchar(100),
        code varchar(100) ,
        shabeeba_id integer REFERENCES shabeeba(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        school_sector_id integer REFERENCES school_sector(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        courses_hosting integer DEFAULT 0,
        created_at timeStamp,
        updated_at timeStamp NULL,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
    );
    CREATE TABLE IF NOT EXISTS students (
          id serial PRIMARY KEY,
          user_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          name varchar(50),
          address varchar(255),
        	national_id varchar(50) UNIQUE,
        	school_id integer REFERENCES schools(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          page_closed integer DEFAULT 0,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS school_representative (
          id serial PRIMARY KEY,
        	name varchar(100),
        	user_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	school_id integer REFERENCES schools(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          email varchar(100),
          enable_reg_type integer,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS school_grades (
          id serial PRIMARY KEY,
        	level_id integer REFERENCES school_level(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          school_id integer REFERENCES schools(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );

      CREATE TABLE IF NOT EXISTS categories (
        id serial PRIMARY KEY,
        name varchar(50) NOT NULL,
        description TEXT ,
        shabeeba_id integer REFERENCES shabeeba(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        created_at timeStamp,
        updated_at timeStamp NULL,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS course (
          id serial PRIMARY KEY,
          course_title varchar(100),
          trainer_id integer REFERENCES trainers(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          category_id integer REFERENCES categories(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	company_id integer REFERENCES company(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	school_id integer REFERENCES schools(id)
          ON UPDATE  CASCADE ON DELETE SET NULL DEFAULT NULL ,
          hosted_course integer DEFAULT 0,
          type varchar(10),
        	course_cost integer,
        	description TEXT,
          start_course timeStamp,
          fixed_course integer DEFAULT 0,
          end_course timeStamp,
        	meetings_number integer,
        	month_meeting_number integer,
        	students_number integer,
          code varchar(50) NULL ,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS school_course (
          id serial PRIMARY KEY,
        	school_id integer REFERENCES schools(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	course_id integer REFERENCES course(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	first_approved integer DEFAULT 0,
        	final_approved integer DEFAULT 0,
          reg_type integer DEFAULT 1,
          active integer DEFAULT 0,
          ended integer DEFAULT 0,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );

      CREATE TABLE IF NOT EXISTS grade_courses (
          id serial PRIMARY KEY,
        	level integer ,
          course_id integer REFERENCES  course(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          shabeeba_id integer REFERENCES  shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          active integer DEFAULT 0,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS events (
          id serial PRIMARY KEY,
          event_name varchar(100),
        	started_at timeStamp,
        	ended_at timeStamp,
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS sessions (
        id serial PRIMARY KEY,
        course_program_id integer REFERENCES course(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        title text,
        date DATE ,
        end_time timeStamp NULL,
        start_time timeStamp NULL,
        created_at timeStamp,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS reports (
          id serial PRIMARY KEY,
          name varchar(50),
          owner integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          session_id integer REFERENCES sessions(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          details text,
          image_url varchar(100),
          notes text,
          attendees_num integer,
          absences_num integer,
        	editable integer,
        	editable_duration integer,
        	notification integer,
        	notification_date varchar(50),
        	followup_school integer,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );

      CREATE TABLE IF NOT EXISTS packages (
          id serial PRIMARY KEY,
          name varchar(50),
          monthly BOOLEAN,
          amount integer,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
        	expiry_date timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS package_owner (
          id serial PRIMARY KEY,
          package_id integer REFERENCES packages(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          amount integer,
          created_at timeStamp,
          updated_at timeStamp,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS package_owner_member (
          id serial PRIMARY KEY,
          shabeeba_package_id integer REFERENCES package_owner(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          user_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          amount integer,
          send_type integer DEFAULT 0,
          send_date varchar(50) NULL,
          created_at timeStamp,
          updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS applications (
          id serial PRIMARY KEY,
        	url_android varchar(100),
        	url_ios varchar(100),
        	image_url varchar(100),
        	description TEXT,
          type VARCHAR(50),
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS student_course (
          id serial PRIMARY KEY,
        	course_id integer REFERENCES course(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	student_id integer REFERENCES students(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          created_at timeStamp,
          updated_at timeStamp,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS evaluation_course (
          id serial PRIMARY KEY,
        	course_id integer REFERENCES course(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	student_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	question_id integer REFERENCES questions(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	evaluation varchar(50),
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );


      CREATE TABLE IF NOT EXISTS files (
          id serial PRIMARY KEY,
          user_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	url VARCHAR(100),
        	allow_to integer REFERENCES user_type(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	course_id integer REFERENCES course(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          name varchar(100),
          details varchar (255),
        	created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );


        CREATE TABLE IF NOT EXISTS attendees (
          id serial PRIMARY KEY,
          student_id integer REFERENCES students(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	attend integer DEFAULT 0,
          created_at timeStamp,
          updated_at timeStamp,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS session_attendees (
          id serial PRIMARY KEY,
          session_id integer REFERENCES sessions(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
        	attend_id integer REFERENCES attendees(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          student_id integer REFERENCES students(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          created_at timeStamp,
          updated_at timeStamp,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS creative_ideas (
          id serial PRIMARY KEY,
          title VARCHAR(100),
          content TEXT,
          created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS project_finance (
          id serial PRIMARY KEY,
          title VARCHAR(100),
          content TEXT,
          created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS view_course_evaluation (
          id serial PRIMARY KEY,
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          course_id integer REFERENCES course(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          created_at timeStamp,
        	updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );

      CREATE TABLE IF NOT EXISTS author (
          id serial PRIMARY KEY,
          user_id integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          email varchar(100),
          created_at timeStamp,
          updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS orders (
          id serial PRIMARY KEY,
          shabeeba_id integer REFERENCES shabeeba(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          order_type integer REFERENCES packages(id)
          ON UPDATE CASCADE ON DELETE CASCADE ,
          details text,
          status integer DEFAULT 0,
          created_at timeStamp,
          updated_at timeStamp NULL,
          created_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE,
          updated_by integer REFERENCES users(id)
          ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS budget (
        id serial PRIMARY KEY,
        amount integer ,
        budget_name varchar(100),
        added_by integer REFERENCES shabeeba(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        started_at timeStamp,
        ended_at timeStamp,
        created_at timeStamp,
        updated_at timeStamp,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
      );
      CREATE TABLE IF NOT EXISTS budget_debit (
        id serial PRIMARY KEY,
        amount integer ,
        school_course_id integer REFERENCES school_course(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        shabeeba_id integer REFERENCES shabeeba(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        budget_id integer REFERENCES budget(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        extrabudget integer DEFAULT 0,
        created_at timeStamp,
        updated_at timeStamp,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
      );

      CREATE TABLE IF NOT EXISTS budget_credit (
        id serial PRIMARY KEY,
        amount integer ,
        course_id integer REFERENCES course(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        shabeeba_id integer REFERENCES shabeeba(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        budget_id integer REFERENCES budget(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        created_at timeStamp,
        updated_at timeStamp,
        created_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
        updated_by integer REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE
      );
    CREATE TABLE IF NOT EXISTS internal_messages (
      id serial PRIMARY KEY ,
      title varchar(255),
      user1 integer REFERENCES users(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
      user2 integer REFERENCES users(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
      message  text NOT NULL,
      deleted_user1 integer ,
      deleted_user2 integer ,
      parent_id integer REFERENCES internal_messages(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
      -- top_level_message_id REFERENCES
      created_at timeStamp,
      updated_at timeStamp,
      created_by integer REFERENCES users(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
      updated_by integer REFERENCES users(id)
      ON UPDATE CASCADE ON DELETE CASCADE
    );
    CREATE TABLE IF NOT EXISTS sms (
      id serial PRIMARY KEY ,
      package_owner_member_id integer REFERENCES package_owner_member(id),
      send_from integer REFERENCES users(id),
      send_to integer REFERENCES users(id),
      created_at timeStamp,
      updated_at timeStamp,
      created_by integer REFERENCES users(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
      updated_by integer REFERENCES users(id)
      ON UPDATE CASCADE ON DELETE CASCADE
    );

    COMMIT;
