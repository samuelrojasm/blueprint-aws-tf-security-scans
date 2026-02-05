# terraform/makefiles/git.mk

.PHONY: git-s3-vulnerable


git-s3-deploy:
	@echo ""
	@echo "🚀 $(CYAN)Realizando add, commit y push...$(RESET)"
	@echo "-------------------------------------"
	@echo "✅ $(CYAN)Realizando add...$(RESET)"
	@echo "--------------------"
	git -C $(S3_VULNERABLE_PATH) add $(GIT_FILE)
	@echo ""
	@echo "✅ $(CYAN)Realizando commit...$(RESET)"
	@echo "----------------------"
	git -C $(S3_VULNERABLE_PATH) commit -m '$(GIT_MSG)'
	@echo ""
	@echo "✅ $(CYAN)Realizando push..$(RESET)"
	@echo "--------------------"
	git -C $(S3_VULNERABLE_PATH) push origin $(GIT_BRANCH)
	@echo ""

git-s3-module-deploy:
	@echo ""
	@echo "🚀 $(CYAN)Realizando add, commit y push...$(RESET)"
	@echo "-------------------------------------"
	@echo "✅ $(CYAN)Realizando add..."
	@echo "--------------------"
	git -C $(S3_MODULE_PATH) add $(GIT_FILE)
	@echo ""
	@echo "✅ $(CYAN)Realizando commit...$(RESET)"
	@echo "----------------------"
	git -C $(S3_MODULE_PATH) commit -m '$(GIT_MSG)'
	@echo ""
	@echo "✅ $(CYAN)Realizando push..$(RESET)"
	@echo "-------------------"
	git -C $(S3_MODULE_PATH) push origin $(GIT_BRANCH)
	@echo ""

git-status:
	@echo ""
	@echo "🚀 $(CYAN)Estado de archivos...$(RESET)"
	@echo "------------------------"
	git status

# ---
