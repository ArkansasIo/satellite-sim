# Ground Station Login UI

Screens:
- Login
- Register
- Forgot/Reset Password
- Logout/session-expired
- User profile
- Administrator user/role management

After login the UI displays the authenticated username and role.

Navigation is permission-aware:
ADMIN -> Administration + all operational views
OPERATOR -> Operations
ANALYST -> Analysis
VIEWER -> Read-only views

The UI must never rely on hidden buttons as the security boundary; the server independently enforces every permission.
