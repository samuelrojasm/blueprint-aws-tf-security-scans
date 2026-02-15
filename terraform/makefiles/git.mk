# terraform/makefiles/git.mk

.PHONY: git-s3-root-sync git-s3-module-sync git-status

git-s3-root-sync: ## Sincroniza S3-root con el repositorio remoto
	$(call git_sync_logic,$(S3_VULNERABLE_PATH))

git-s3-module-sync: ## Sincroniza el mpodulo de S3 con el repositorio remoto
	$(call git_sync_logic,$(S3_MODULE_PATH))

git-sg-root-sync: ## Sincroniza Security Group Vulnerable con el repositorio remoto
	$(call git_sync_logic,$(SG_VULNERABLE_PATH))

git-status:
	@echo ""
	@echo "🚀 $(CYAN)Estado de archivos...$(RESET)"
	@echo "------------------------"
	git status

# --- Lógica Centralizada (Template) ---
# $(1): Ruta del directorio
define git_sync_logic
	@echo ""
	@echo "⚙️ $(CYAN)Sincronizando con remoto (git pull)...$(RESET)"
	@echo "--------------------------------------------------"
	@git -C $(1) pull origin $(GIT_BRANCH) || (echo "❌ $(RED)Error: Conflictos detectados. Resuelve manualmente.$(RESET)"; exit 1)
	
	@echo ""
	@echo "📦 $(CYAN)Preparando cambios (git add)...$(RESET)"
	@echo "--------------------------------------------------"
	@printf "$(YELLOW)git -C $(1) add $(GIT_FILE)$(RESET)\n"
	@git -C $(1) add $(GIT_FILE)

	@echo ""
	@echo "➕ $(CYAN)Realizando (git commit)..$(RESET)"
	@echo "--------------------------------------------------"
	@printf "$(YELLOW)git -C $(1) commit -m \"$(GIT_MSG)\"$(RESET)\n"
	@git -C $(1) commit -m "$(GIT_MSG)"
	
	@echo ""
	@echo "📤 $(CYAN)Subiendo cambios a $(GIT_BRANCH)...$(RESET)"
	@echo "--------------------------------------------------"
	@printf "$(YELLOW)git -C $(1) push origin $(GIT_BRANCH)$(RESET)\n"
	@git -C $(1) push origin $(GIT_BRANCH)

	@echo ""
	@echo "🚀 $(GREEN)¡Actualización completada con éxito en $(1)!$(RESET)"
	@echo ""
endef

# ---

