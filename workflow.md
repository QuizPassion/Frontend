# **Quizzy-Git Branching and Workflow Guidelines**

<div style="text-align: center;">
  <img src="quizzy/assets/logo/logo_whole.png" alt="quizzy-logo" style="width:400px;" />
</div>

##  Branch Organization

### 1. Main Branches
- **main**: Main branch representing the pre-production environment
- **staging**: Branch used for testing and validation

### 2. Working Branches
- **Prefixed by domain** to indicate the area of work :  
    `auth/`: Changes related to authentication  
    `auth/user-authentication`

---

## GitHub Workflow

### 1. Branch Creation
Work on a dedicated branch for each feature or fix

### 2. Merge to Staging
Merge the feature branch into `staging`  
Run tests to validate changes

### 3. Validation and Backup
Before merging into `main`, perform a backup to prevent any issues

### 4. Update Main
Merge `staging` into `main` after full validation by another team member

---

## Branch Naming Rules

- **Language**: All branch names must be in English
- **Format**: Use `kebab-case` to describe the task  
    `users/user-auth`

---

## Commit Naming Rules

- **Language**: Commits must be written in English

### Types:
- `feat`: for new features  
- `fix`: for bug fixes  
- `update`: for general updates

### Convention:
Use the conventional commit format :  
`<type>[optional scope]: <description>`

#### Examples:
```bash
feat(login): added login button  
fix(logout): fixed logout_button redirection
```

---

## Language Guidelines
1. **Commits and Merge Requests** : must be written in English  
``Example: Fix: add user authentication``

2. **Code Comments** : always use English  
``Example: // allows to send the user to...``

3. **Technical Documentation** : use english for README files and installation guides

4. **Variable Naming** : Always use English
    ```js
    const calculateTotalPrice = (cartItems: Item[]): number => { ... }
    ```

## Best Practices
1. **Consistency** : Strictly follow all established conventions

2. **Readability** : Use explicit names avoid non-standard abbreviations

3. **Documentation** : Add comments to explain complex logic or sections

4. **Git Workflow** : Use well-named, descriptive branches  
    ```bash
    feature/add-payment-method
    bugfix/fix-cart-bug
    ```