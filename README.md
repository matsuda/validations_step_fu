# ValidationsStepFu

## Description

1つのモデルの入力フォームが複数のページにまたがる場合のvalidationsをDRYに保つためのRails 3プラグイン


## Example

以下のように User モデルの入力フォームが複数のページにまたがる場合

### views

    # app/views/users/step1.html.erb
    <%- form_for @user, :url => step2_user_path do |f| -%>
    <%= f.text_field :name %>
    <%- end -%>

    # app/views/users/step2.html.erb
    <%- form_for @user, :url => confirm_new_user_path do |f| -%>
    <%= f.text_field :age %>
    <%= f.text_field :hobby %>
    <%- end -%>

### controllers

    # app/controllers/users_controller.rb
    def step2
      unless @user.valid_step_2?
        render :new and return
      end
    end

    def confirm
      unless @user.valid_step_confirm?
        render :step1 and return
      end
    end

このプラグインを使わない場合のvalidationの実装

### models

    # app/models/user.rb
    validates :name, :presence => true, :length => { :maximum => 30 }
    validates :age, :hobby, :presence => true

    def valid_step_2?
      self.errors.clear
      if self.name.blank? # <- oops!
        self.errors.add :name, :blank
      elsif self.name.length > 30 # <- oops!
        self.errors.add :name, :too_long, :count => 30
      end
      self.errors.empty?
    end

    def valid_step_confirm?
      self.errors.clear
      if self.age.blank? # <- oops!
        self.errors.add :age, :blank
      end
      if self.hobby.blank? # <- oops!
        self.errors.add :hobby, :blank
      end
      self.errors.empty?
    end

このプラグインを使った場合のvalidationの実装

    # app/models/user.rb
    validates :name, :presence => true, :length => { :maximum => 30 }
    validates :age, :hobby, :presence => true
    
    def valid_step_2?
      self.errors.clear
      validates_step_by(:name) # <- awesome!
      self.errors.empty?
    end
    
    def valid_step_confirm?
      self.errors.clear
      validates_step_by(:age, :hobby) # <- awesome!
      self.errors.empty?
    end

また、以下のようにも書くことが可能

    # app/models/user.rb
    validates :name, :presence => true, :length => { :maximum => 30 }
    validates :age, :hobby, :presence => true
    
    define_step_validation '1', :name # <- awesome!
    define_step_validation :confirm, :age, :hobby # <- awesome!


## Features

### instance methods

* validates\_step\_by

### class methods

* define\_step\_validation



Copyright (c) 2011 Kosuke Matsuda, released under the MIT license
