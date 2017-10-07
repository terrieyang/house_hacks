class RecipesController < ApplicationController
	#https://rbudiharso.wordpress.com/2010/07/07/dynamically-add-and-remove-input-field-in-rails-without-javascript/#jp-carousel-119

	autocomplete :ingredient, :name, :full => true

	def index
		@recipes = Recipe.all
	end

	#show info for one recipe
	def show
		@recipe = Recipe.find(params[:id])
	end

	#form for a new recipe
	def new
		@recipe = Recipe.new
		@recipe.ingredients.build
	end

	#edit a recipe
	def edit
		@recipe = Recipe.find(params[:id])
	end

	#update recipe
	def update
		@recipe = Recipe.find(params[:id])
		if params[:add_ingredient]
			@recipe.ingredients.build
    	# # rebuild the ingredient attributes that doesn't have an id
    	# 	unless params[:recipe][:ingredients_attributes].blank?
	  		# 	for attribute in params[:recipe][:ingredients_attributes]
	    # 			@recipe.ingredients.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	  		# 	end
    	# 	end
     #  		# add one more empty ingredient attribute
     #  		@recipe.ingredients.build
    	elsif params[:remove_ingredient]
      		# # collect all marked for delete ingredient ids
      		# removed_ingredients = params[:recipe][:ingredients_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
      		# # physically delete the ingredients from database
      		# Ingredient.delete(removed_ingredients)
      		# flash[:notice] = "Ingredients removed."
      		# for attribute in params[:recipe][:ingredients_attributes]
      		# 	# rebuild ingredients attributes that doesn't have an id and its _destroy attribute is not 1
        # 		@recipe.ingredients.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      		# end
    	else
		 
		    if @recipe.update(recipe_params)
		      redirect_to @recipe, notice: "Recipe successfully updated!"
		    else
		      render :edit
		    end
		 end
	 end

	#creates the new reicpe
	def create
		@recipe = Recipe.new(recipe_params)
		if params[:add_ingredient]
			@recipe.ingredients.
		elsif params[:remove_ingredient]
			# nested model that have _destroy attribute = 1 automatically deleted by rails
		else
			if @recipe.save
				redirect_to @recipe, notice: 'Recipe successfully created!'
		# else
		# 	render :new, :alert @recipes.errors
			end
		end
	end

	#delete recipe
	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy
    	redirect_to recipes_url, alert: "Recipe successfully deleted!"
	end

	def recipe_params
		params.require(:recipe).permit(:name, :servings, :rating, :target, :time)
	end

end
