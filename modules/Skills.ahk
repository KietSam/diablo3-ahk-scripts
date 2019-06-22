SkillPoint(n, x_shift:=0, y_shift:=0) {
  return Point(877 + (n - 1) * 90 + x_shift, 1371 + y_shift)
}

SkillClick(n) {
  ClickPoint(SkillPoint(n))
}

SkillIsActive(n) {
  ; n: The skill slot, index starts at 1.
  ;    e.g: 1 | 2 | 3 | 4
  return !ColorPointSimilarTo(SkillPoint(n, -27, -44), 0x000000, 6, 6, 3)
}

SkillIsOnCooldown(n) {
  ; n: The skill slot, index starts at 1.
  ;    e.g: 1 | 2 | 3 | 4
  return !ColorPointSimilarTo(SkillPoint(n, -7, -34), 0x52696B, 6, 6, 3)
}

SkillIsAvailable(n) {
  ; A skill is considered "available" if:
  ;  1. Is currently inactive
  ;  2. Is not on cooldown
  ; n: The skill slot, index starts at 1.
  ;    e.g: 1 | 2 | 3 | 4
  return !SkillIsActive(n) && !SkillIsOnCooldown(n)
}