# Discovery solution review note

This branch introduces the authoritative solution layer beneath the Journal hint system.

Review focus:

1. blocker precedence — especially dirty/unsafe input vs heat/time;
2. which recipes are soft-discoverable vs hard-gated;
3. whether any recipe corrections are too explicit or too vague;
4. whether quality failures should produce low-quality items instead of hard failure;
5. whether the proposed implementation contract is strict enough to prevent hint spam and progression skips.

This note is branch-local review guidance and may be removed before final merge if desired.
