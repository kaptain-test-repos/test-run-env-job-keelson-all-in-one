# Test Run Env Job Keelson All In One

E2E test repo for the `kubernetes-run-environment` build in buildon-github-actions.

Tests deployMode `job` with imageAutoUpdateProvider `keelson` (the pairing that
exists because keel cannot trigger jobs): the deploy image side is a suspended
CronJob with `trigger-job-on-update` plus a ZERO-SCALE debug Deployment that an
operator can scale to 1 to explore/fix on the rare occasions that's needed.
All-in-one cluster-scope model (`clusterScopedDelegation: self`). Both
ConfigMap and Secret are SUPPLIED as checksum-named templates in
`src/environment` - exercises the fail-if-not-checksum-named enforcement, the
templates-in-early-before-generation ordering, and that the build does NOT
generate resources that were supplied. Also overrides an auto-update default
(`imageAutoUpdatePollSchedule: 5m`).

Consumed as a child by `test-run-platform-seed-only`.

## Secrets

`src/secrets/*.age` are real age-encrypted values (HHGTTG quotes - this is a
test fixture, nothing sensitive). The key is published here ON PURPOSE so any
engineer can inspect/decrypt/re-encrypt them with the kaptain-user-scripts
tooling (`kaptain-decrypt` / `kaptain-encrypt`):

```
AGE-SECRET-KEY-17DT7C08VAM4N4QCJUG7HRNSRDNVADJAXH0FWT80FJQLLC5DS8TDQQP7AAD
```

Never do this in a real project.

Pending notes:

- Uses draft schema fields (`clusterScopedDelegation`,
  `imageAutoUpdatePollSchedule`) from the uncommitted `spec-kaptainpm-schema`
  repo; the schema must be faked into the build before this repo can build.
- Behaviour assertions (suspended CronJob, zero-scale Deployment, keelson
  annotations, no generated CM/Secret) get added to the hooks once the
  reference scripts land.
