Received: from cvsmtppost12.nm.naver.com (cvsmtppost12.nm.naver.com [114.111.35.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72F2EA749
	for <linux-integrity@vger.kernel.org>; Thu,  8 Oct 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467609; cv=none; b=H4qapLCi0iQjxbx+kxU545AtITIZ1Vg1CIndhUmcv4j7+l1uhBd/AEws8/dQz4wIuJi/hTincZUvhPjkhyJk+zuOPtctKiq7p+1Y0IKDQO+VHch8xnFUrKeu70DPVcIBkhpq6RIfJIwLpRf1xORMsSchsvdMUomXsjP/nhLsCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467609; c=relaxed/simple;
	bh=wyGXtfojEgDZrNbSwsz4u+SAacosZ6GQXQRtZOmw9uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbEy4nif7dFHz6LfYzTOMa1sHKlPNhzzDKOdhUNa+dZq3rumNz+V3GPriPLJGGV/AoduTe1EsDeuux/ItdRNLH3Mi6LCToonFPec+9jv3V+s6jdTbEf1XWxta4yCp1TQcTquopKm5r/CoOFEDMMRuzggNVdNJ/MlpB84YHhEkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=n6mEl7/x; arc=none smtp.client-ip=114.111.35.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="n6mEl7/x"
Received: from cvsendbo002.nm ([10.112.20.42])
  by cvsmtppost12.nm.naver.com with ESMTP id rJEqBw2JSmuJy-EyCDLfBw
  for <linux-integrity@vger.kernel.org>;
  Thu, 08 Oct 2026 13:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791466997; bh=wyGXtfojEgDZrNbSwsz4u+SAacosZ6GQXQRtZOmw9uk=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=n6mEl7/xZ+ICNNK8VnAezyRbP9eF/QXg/HmpkOhw/Z/Wx1Q4zffZPyO8//hrwdNBs
	 pqgdhO/K3qXiUuUooxTiGgFzP1qxAYAoMTuMnEDZsYt+FOsaq+u0nieHX3zqZIzRcy
	 ww607c/ZkiGYjnHwILZx1O9BcZ1s0CyXXP7Sk19MeQAGKIh4s3oa6VPynt6NKLQOEE
	 c0hW512vSLijrfW1eBXxg6QNGV/hCsHg57L+6SUKGRbwwLjdF+BSLDHakSKSp3TbJD
	 kzVzQrJkSHIXul6PXzi9kmP5cbAiccF9t1OLzzLiVW6o95elxJhEvhM7FB5MN9fTMg
	 G9u7hYlTQwvCA==
X-Session-ID: 2jGbGJj6T+SFia+GePgcnQ
X-Works-Send-Opt: OP+wpzGdjHmdKHFOMr39Ko3YKBmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: l9KqFAulFqJZ+HmraxEd+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by mvnsmtp06.nm.naver.com with ESMTP id 2jGbGJj6T+SFia+GePgcnQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 13:43:16 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com
Cc: linux-integrity@vger.kernel.org,
	Sung Byeongchan <tjdqudcks0424@naver.com>
Subject: [PATCH] ima: bind cached appraisal results to policy identity
Date: Thu,  8 Oct 2026 22:43:09 +0900
Message-ID: <20261008134309.276625-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IMA caches an appraisal result per inode and hook, but does not record the
policy rule which produced it.  A file accepted through a weaker subject
rule can therefore retain PASS when a later, stronger subject matches a
rule which requires a signature.  Replacing LSM-backed rules on policy
reload leaves the same stale result usable as well.

Assign stable rule IDs and maintain a monotonic appraisal policy
generation.  Record both with the inode's appraisal result, and clear
appraisal state when the next matching rule or generation differs.  This
preserves same-rule cache reuse while preventing PASS from crossing rule
and policy identities.

On ff47652a4b66, complete IMA policy publication and the one-reload and
two-reload cases each reproduced the stale allow in three fresh boots.
With this change, the stronger consumer was denied in all nine
corresponding runs.  Same-rule reuse, unprimed and new-inode denial,
content and xattr invalidation, and normal policy reload controls passed.
All touched source blobs are byte-identical and the four changed IMA
objects build successfully at 47324d3a5b3a.  This is an appraisal
authorization bypass; no RCE or LPE primitive is claimed.

This issue was found through manual source inspection assisted by an
AI/LLM, then evaluated with local production-path dynamic validation.

Fixes: d79d72e02485 ("ima: per hook cache integrity appraisal status")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 security/integrity/ima/ima.h          | 13 +++++++++++--
 security/integrity/ima/ima_api.c      |  5 +++--
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     | 25 +++++++++++++++++++++----
 security/integrity/ima/ima_policy.c   | 21 ++++++++++++++++++++-
 5 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 10214f73ca1ed..4ed21e731fe7d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -229,6 +229,8 @@ struct ima_iint_cache {
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct integrity_inode_attributes real_inode;
 	unsigned long flags;
+	u64 appraisal_rule_id;
+	u64 appraisal_policy_generation;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
 	enum integrity_status ima_file_status:4;
@@ -239,6 +241,11 @@ struct ima_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
+struct ima_appraisal_rule_id {
+	u64 rule_id;
+	u64 policy_generation;
+};
+
 extern struct lsm_blob_sizes ima_blob_sizes;
 
 static inline struct ima_iint_cache *
@@ -427,7 +434,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, struct lsm_prop *prop, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos);
+		   const char *func_data, unsigned int *allowed_algos,
+		   struct ima_appraisal_rule_id *appraisal_rule);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			    void *buf, loff_t size, enum hash_algo algo,
@@ -458,7 +466,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, struct lsm_prop *prop,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos);
+		     const char *func_data, unsigned int *allowed_algos,
+		     struct ima_appraisal_rule_id *appraisal_rule);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flags(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127e108dc..bc049d257db95 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -192,7 +192,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, struct lsm_prop *prop, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *func_data, unsigned int *allowed_algos)
+		   const char *func_data, unsigned int *allowed_algos,
+		   struct ima_appraisal_rule_id *appraisal_rule)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
@@ -200,7 +201,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 
 	return ima_match_policy(idmap, inode, cred, prop, func, mask,
 				flags, pcr, template_desc, func_data,
-				allowed_algos);
+				allowed_algos, appraisal_rule);
 }
 
 static bool ima_get_verity_digest(struct ima_iint_cache *iint,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index b280488e15fcb..1a3cde20a733c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -82,7 +82,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 	security_current_getlsmprop_subj(&prop);
 	return ima_match_policy(idmap, inode, current_cred(), &prop,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
-				NULL, NULL, NULL);
+				NULL, NULL, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache *iint)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ab1e53b3210d3..b85732bc1285a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -272,6 +272,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	struct ima_appraisal_rule_id appraisal_rule = {};
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -282,7 +283,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, prop,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos);
+				&allowed_algos, &appraisal_rule);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE) &&
@@ -364,6 +365,22 @@ static int process_measurement(struct file *file, const struct cred *cred,
 					 IMA_APPRAISED_SUBMASK);
 	}
 
+	/*
+	 * An appraisal result is reusable only for the policy rule which
+	 * produced it.  A weaker rule must not prime the inode cache for a
+	 * later, stronger rule matching another subject or policy context.
+	 */
+	if (must_appraise &&
+	    (iint->appraisal_rule_id != appraisal_rule.rule_id ||
+	     iint->appraisal_policy_generation !=
+					appraisal_rule.policy_generation)) {
+		iint->flags &= ~(IMA_APPRAISED | IMA_APPRAISED_SUBMASK |
+				 IMA_NONACTION_RULE_FLAGS);
+		iint->appraisal_rule_id = appraisal_rule.rule_id;
+		iint->appraisal_policy_generation =
+					appraisal_rule.policy_generation;
+	}
+
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
@@ -563,11 +580,11 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				current_cred(), &prop, MAY_EXEC, MMAP_CHECK,
-				&pcr, &template, NULL, NULL);
+				&pcr, &template, NULL, NULL, NULL);
 	action |= ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				 current_cred(), &prop, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
-				 NULL);
+				 NULL, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -1143,7 +1160,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 		security_current_getlsmprop_subj(&prop);
 		action = ima_get_action(idmap, inode, current_cred(),
 					&prop, 0, func, &pcr, &template,
-					func_data, NULL);
+					func_data, NULL, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
 			return -ENOENT;
 	}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 68d9a5e6c232e..5e88e6798a78f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -59,6 +59,9 @@ int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
 
+static atomic64_t ima_rule_id = ATOMIC64_INIT(0);
+static atomic64_t ima_policy_generation = ATOMIC64_INIT(1);
+
 atomic_t ima_setxattr_allowed_hash_algorithms;
 
 #define MAX_LSM_RULES 6
@@ -101,6 +104,7 @@ static inline bool vfsgid_lt_kgid(vfsgid_t vfsgid, kgid_t kgid)
 
 struct ima_rule_entry {
 	struct list_head list;
+	u64 rule_id;
 	int action;
 	unsigned int flags;
 	enum ima_hooks func;
@@ -511,6 +515,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 	if (event != LSM_POLICY_CHANGE)
 		return NOTIFY_DONE;
 
+	/* Readers using either old or replacement rules must not reuse a PASS. */
+	atomic64_inc(&ima_policy_generation);
 	ima_lsm_update_rules();
 	return NOTIFY_OK;
 }
@@ -754,6 +760,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @template_desc: the template that should be used for this rule
  * @func_data: func specific data, may be NULL
  * @allowed_algos: allowlist of hash algorithms for the IMA xattr
+ * @appraisal_rule: identity of the matched appraisal rule
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -766,7 +773,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, struct lsm_prop *prop,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *func_data, unsigned int *allowed_algos)
+		     const char *func_data, unsigned int *allowed_algos,
+		     struct ima_appraisal_rule_id *appraisal_rule)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -790,6 +798,11 @@ int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 
 		action |= entry->action & IMA_DO_MASK;
 		if (entry->action & IMA_APPRAISE) {
+			if (appraisal_rule) {
+				appraisal_rule->rule_id = entry->rule_id;
+				appraisal_rule->policy_generation =
+					atomic64_read(&ima_policy_generation);
+			}
 			action |= get_subaction(entry, func);
 			action &= ~IMA_HASH;
 			if (ima_fail_unverifiable_sigs)
@@ -895,6 +908,9 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
 
+		if (!entries[i].rule_id)
+			entries[i].rule_id = atomic64_inc_return(&ima_rule_id);
+
 		if (policy_rule & IMA_DEFAULT_POLICY)
 			list_add_tail(&entries[i].list, &ima_default_rules);
 
@@ -1065,6 +1081,8 @@ void ima_update_policy(void)
 {
 	struct list_head *policy = &ima_policy_rules;
 
+	/* Invalidate appraisal results before publishing appended rules. */
+	atomic64_inc(&ima_policy_generation);
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
 	if (ima_rules != (struct list_head __rcu *)policy) {
@@ -2006,6 +2024,7 @@ ssize_t ima_parse_add_rule(char *rule)
 				    audit_info);
 		return result;
 	}
+	entry->rule_id = atomic64_inc_return(&ima_rule_id);
 
 	list_add_tail(&entry->list, &ima_temp_rules);
 

base-commit: 47324d3a5b3abd781295044d01d92d09f184e872
-- 
2.43.0

