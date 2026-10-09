Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4693F0A81
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535139; cv=none; b=RRjz0jkYKh1FsLu8DE9mZ20Z5nymv9f5xoNq05Svs0lR0vh5WVwID8mZXCaybiMJqKtR1bngu5iTKP6InPwdemzr4QmlBIJM2YV0xMKSHvRyennXRrwBDVPXUAxL4QkSD7Hx/GH5fhesj29fvdAHv6imV8cxkf3zDpc5kdBr6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535139; c=relaxed/simple;
	bh=eHSJHFeHIldWKcgm30qXvdjqXRviTowQjwzPSxEXDy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+wtceSKC7LIJM+8YrrvhB2orQx/p8abEcfxKjeR5qrEK6LQBLbITr9f/gEziImZvdRN9BYeADS4Ov5avkv0kvXgBvoe19kX5wDqYejqBDAtdE7PLghNB5Q97ib63L1/fqQScugUZiBt9/N1Tl5t6aBpz35cgiXptHRAQLxOmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4j1KMc0swtzpTRZ
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 16:11:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 514E940009
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 16:19:49 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with UTF8SMTPA id LxC2BwDHza2eo8hqmya8AQ--.16282S2;
	Fri, 09 Oct 2026 09:19:48 +0100 (CET)
Message-ID: <b331fb0d0c787cdec43b6aa74b8db8dd0f4b3218.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: bind cached appraisal results to policy identity
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com
Cc: linux-integrity@vger.kernel.org
Date: Fri, 09 Oct 2026 10:19:39 +0200
In-Reply-To: <20261008134309.276625-1-tjdqudcks0424@naver.com>
References: <20261008134309.276625-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHza2eo8hqmya8AQ--.16282S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJrW8uryDAr1rXFyxCryDWrg_yoW8GryrXo
	WfK39rJF4rGry3Cay8uFn5tFWxuay5Grs3JFW8WrZ8G3ZFq34DG3y3ur17ZF4fuF15JF4U
	C347X3y8tF1ktas5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5K7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r1j6r4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGrIkZ4K0AAAsw

On Thu, 2026-10-08 at 22:43 +0900, Sung Byeongchan wrote:
> IMA caches an appraisal result per inode and hook, but does not record th=
e
> policy rule which produced it.  A file accepted through a weaker subject
> rule can therefore retain PASS when a later, stronger subject matches a
> rule which requires a signature.  Replacing LSM-backed rules on policy
> reload leaves the same stale result usable as well.

Hi Sung

I take the opportunity to remind everyone that the contributor is the
sole responsible for what the contributor sends, regardless of the tool
used to make the contribution. Therefore, it is task of the contributor
to have fully understood the problem and being confident on the
proposed solution.

With that said, I have a question. In your design, you assign a rule ID
to each iint cache. What happens if the cache is matched by another
rule (for example with different subject credential), and the rules
have similar requirements? I might have understood wrong, but if there
is a match from a different rule, you invalidate the cache, correct? If
the requirements are similar, the cache should be ok to use.

I think the right solution for this problem is to record in the iint
which appraisals you did, and require to do the missing one depending
on what is required by the rule. If the iint cached a weaker appraisal,
you still need to do the stronger one, since that is not cached.

If you decide to follow up, I would expect a proper patch with proper
motivations and following the kernel code guidelines and submission
process (e.g., using checkpatch.pl and get_maintainer.pl).

What is the relevance of the commits you mentioned, since you added a
commit in the Fixes tag which could potentially be the problem? Anyway,
if you decide to contribute, the feature will be significant, I don't
expect it will be suitable for stable kernels.

Thanks

Roberto

> Assign stable rule IDs and maintain a monotonic appraisal policy
> generation.  Record both with the inode's appraisal result, and clear
> appraisal state when the next matching rule or generation differs.  This
> preserves same-rule cache reuse while preventing PASS from crossing rule
> and policy identities.
>=20
> On ff47652a4b66, complete IMA policy publication and the one-reload and
> two-reload cases each reproduced the stale allow in three fresh boots.
> With this change, the stronger consumer was denied in all nine
> corresponding runs.  Same-rule reuse, unprimed and new-inode denial,
> content and xattr invalidation, and normal policy reload controls passed.
> All touched source blobs are byte-identical and the four changed IMA
> objects build successfully at 47324d3a5b3a.  This is an appraisal
> authorization bypass; no RCE or LPE primitive is claimed.
>=20
> This issue was found through manual source inspection assisted by an
> AI/LLM, then evaluated with local production-path dynamic validation.
>=20
> Fixes: d79d72e02485 ("ima: per hook cache integrity appraisal status")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
> ---
>  security/integrity/ima/ima.h          | 13 +++++++++++--
>  security/integrity/ima/ima_api.c      |  5 +++--
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/ima/ima_main.c     | 25 +++++++++++++++++++++----
>  security/integrity/ima/ima_policy.c   | 21 ++++++++++++++++++++-
>  5 files changed, 56 insertions(+), 10 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 10214f73ca1ed..4ed21e731fe7d 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -229,6 +229,8 @@ struct ima_iint_cache {
>  	struct mutex mutex;	/* protects: version, flags, digest */
>  	struct integrity_inode_attributes real_inode;
>  	unsigned long flags;
> +	u64 appraisal_rule_id;
> +	u64 appraisal_policy_generation;
>  	unsigned long measured_pcrs;
>  	unsigned long atomic_flags;
>  	enum integrity_status ima_file_status:4;
> @@ -239,6 +241,11 @@ struct ima_iint_cache {
>  	struct ima_digest_data *ima_hash;
>  };
> =20
> +struct ima_appraisal_rule_id {
> +	u64 rule_id;
> +	u64 policy_generation;
> +};
> +
>  extern struct lsm_blob_sizes ima_blob_sizes;
> =20
>  static inline struct ima_iint_cache *
> @@ -427,7 +434,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct in=
ode *inode,
>  		   const struct cred *cred, struct lsm_prop *prop, int mask,
>  		   enum ima_hooks func, int *pcr,
>  		   struct ima_template_desc **template_desc,
> -		   const char *func_data, unsigned int *allowed_algos);
> +		   const char *func_data, unsigned int *allowed_algos,
> +		   struct ima_appraisal_rule_id *appraisal_rule);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func)=
;
>  int ima_collect_measurement(struct ima_iint_cache *iint, struct file *fi=
le,
>  			    void *buf, loff_t size, enum hash_algo algo,
> @@ -458,7 +466,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct =
inode *inode,
>  		     const struct cred *cred, struct lsm_prop *prop,
>  		     enum ima_hooks func, int mask, int flags, int *pcr,
>  		     struct ima_template_desc **template_desc,
> -		     const char *func_data, unsigned int *allowed_algos);
> +		     const char *func_data, unsigned int *allowed_algos,
> +		     struct ima_appraisal_rule_id *appraisal_rule);
>  void ima_init_policy(void);
>  void ima_update_policy(void);
>  void ima_update_policy_flags(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 122d127e108dc..bc049d257db95 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -192,7 +192,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct in=
ode *inode,
>  		   const struct cred *cred, struct lsm_prop *prop, int mask,
>  		   enum ima_hooks func, int *pcr,
>  		   struct ima_template_desc **template_desc,
> -		   const char *func_data, unsigned int *allowed_algos)
> +		   const char *func_data, unsigned int *allowed_algos,
> +		   struct ima_appraisal_rule_id *appraisal_rule)
>  {
>  	int flags =3D IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
> =20
> @@ -200,7 +201,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct in=
ode *inode,
> =20
>  	return ima_match_policy(idmap, inode, cred, prop, func, mask,
>  				flags, pcr, template_desc, func_data,
> -				allowed_algos);
> +				allowed_algos, appraisal_rule);
>  }
> =20
>  static bool ima_get_verity_digest(struct ima_iint_cache *iint,
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index b280488e15fcb..1a3cde20a733c 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -82,7 +82,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct i=
node *inode,
>  	security_current_getlsmprop_subj(&prop);
>  	return ima_match_policy(idmap, inode, current_cred(), &prop,
>  				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
> -				NULL, NULL, NULL);
> +				NULL, NULL, NULL, NULL);
>  }
> =20
>  static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache *i=
int)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index ab1e53b3210d3..b85732bc1285a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -272,6 +272,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  	bool violation_check;
>  	enum hash_algo hash_algo;
>  	unsigned int allowed_algos =3D 0;
> +	struct ima_appraisal_rule_id appraisal_rule =3D {};
> =20
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>  		return 0;
> @@ -282,7 +283,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  	 */
>  	action =3D ima_get_action(file_mnt_idmap(file), inode, cred, prop,
>  				mask, func, &pcr, &template_desc, NULL,
> -				&allowed_algos);
> +				&allowed_algos, &appraisal_rule);
>  	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK =
||
>  			    func =3D=3D MMAP_CHECK_REQPROT) &&
>  			   (ima_policy_flag & IMA_MEASURE) &&
> @@ -364,6 +365,22 @@ static int process_measurement(struct file *file, co=
nst struct cred *cred,
>  					 IMA_APPRAISED_SUBMASK);
>  	}
> =20
> +	/*
> +	 * An appraisal result is reusable only for the policy rule which
> +	 * produced it.  A weaker rule must not prime the inode cache for a
> +	 * later, stronger rule matching another subject or policy context.
> +	 */
> +	if (must_appraise &&
> +	    (iint->appraisal_rule_id !=3D appraisal_rule.rule_id ||
> +	     iint->appraisal_policy_generation !=3D
> +					appraisal_rule.policy_generation)) {
> +		iint->flags &=3D ~(IMA_APPRAISED | IMA_APPRAISED_SUBMASK |
> +				 IMA_NONACTION_RULE_FLAGS);
> +		iint->appraisal_rule_id =3D appraisal_rule.rule_id;
> +		iint->appraisal_policy_generation =3D
> +					appraisal_rule.policy_generation;
> +	}
> +
>  	/* Determine if already appraised/measured based on bitmask
>  	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
>  	 *  IMA_AUDIT, IMA_AUDITED)
> @@ -563,11 +580,11 @@ static int ima_file_mprotect(struct vm_area_struct =
*vma, unsigned long reqprot,
>  	inode =3D file_inode(vma->vm_file);
>  	action =3D ima_get_action(file_mnt_idmap(vma->vm_file), inode,
>  				current_cred(), &prop, MAY_EXEC, MMAP_CHECK,
> -				&pcr, &template, NULL, NULL);
> +				&pcr, &template, NULL, NULL, NULL);
>  	action |=3D ima_get_action(file_mnt_idmap(vma->vm_file), inode,
>  				 current_cred(), &prop, MAY_EXEC,
>  				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
> -				 NULL);
> +				 NULL, NULL);
> =20
>  	/* Is the mmap'ed file in policy? */
>  	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
> @@ -1143,7 +1160,7 @@ int process_buffer_measurement(struct mnt_idmap *id=
map,
>  		security_current_getlsmprop_subj(&prop);
>  		action =3D ima_get_action(idmap, inode, current_cred(),
>  					&prop, 0, func, &pcr, &template,
> -					func_data, NULL);
> +					func_data, NULL, NULL);
>  		if (!(action & IMA_MEASURE) && !digest)
>  			return -ENOENT;
>  	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 68d9a5e6c232e..5e88e6798a78f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -59,6 +59,9 @@ int ima_policy_flag;
>  static int temp_ima_appraise;
>  static int build_ima_appraise __ro_after_init;
> =20
> +static atomic64_t ima_rule_id =3D ATOMIC64_INIT(0);
> +static atomic64_t ima_policy_generation =3D ATOMIC64_INIT(1);
> +
>  atomic_t ima_setxattr_allowed_hash_algorithms;
> =20
>  #define MAX_LSM_RULES 6
> @@ -101,6 +104,7 @@ static inline bool vfsgid_lt_kgid(vfsgid_t vfsgid, kg=
id_t kgid)
> =20
>  struct ima_rule_entry {
>  	struct list_head list;
> +	u64 rule_id;
>  	int action;
>  	unsigned int flags;
>  	enum ima_hooks func;
> @@ -511,6 +515,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, =
unsigned long event,
>  	if (event !=3D LSM_POLICY_CHANGE)
>  		return NOTIFY_DONE;
> =20
> +	/* Readers using either old or replacement rules must not reuse a PASS.=
 */
> +	atomic64_inc(&ima_policy_generation);
>  	ima_lsm_update_rules();
>  	return NOTIFY_OK;
>  }
> @@ -754,6 +760,7 @@ static int get_subaction(struct ima_rule_entry *rule,=
 enum ima_hooks func)
>   * @template_desc: the template that should be used for this rule
>   * @func_data: func specific data, may be NULL
>   * @allowed_algos: allowlist of hash algorithms for the IMA xattr
> + * @appraisal_rule: identity of the matched appraisal rule
>   *
>   * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>   * conditions.
> @@ -766,7 +773,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struct =
inode *inode,
>  		     const struct cred *cred, struct lsm_prop *prop,
>  		     enum ima_hooks func, int mask, int flags, int *pcr,
>  		     struct ima_template_desc **template_desc,
> -		     const char *func_data, unsigned int *allowed_algos)
> +		     const char *func_data, unsigned int *allowed_algos,
> +		     struct ima_appraisal_rule_id *appraisal_rule)
>  {
>  	struct ima_rule_entry *entry;
>  	int action =3D 0, actmask =3D flags | (flags << 1);
> @@ -790,6 +798,11 @@ int ima_match_policy(struct mnt_idmap *idmap, struct=
 inode *inode,
> =20
>  		action |=3D entry->action & IMA_DO_MASK;
>  		if (entry->action & IMA_APPRAISE) {
> +			if (appraisal_rule) {
> +				appraisal_rule->rule_id =3D entry->rule_id;
> +				appraisal_rule->policy_generation =3D
> +					atomic64_read(&ima_policy_generation);
> +			}
>  			action |=3D get_subaction(entry, func);
>  			action &=3D ~IMA_HASH;
>  			if (ima_fail_unverifiable_sigs)
> @@ -895,6 +908,9 @@ static void add_rules(struct ima_rule_entry *entries,=
 int count,
>  	for (i =3D 0; i < count; i++) {
>  		struct ima_rule_entry *entry;
> =20
> +		if (!entries[i].rule_id)
> +			entries[i].rule_id =3D atomic64_inc_return(&ima_rule_id);
> +
>  		if (policy_rule & IMA_DEFAULT_POLICY)
>  			list_add_tail(&entries[i].list, &ima_default_rules);
> =20
> @@ -1065,6 +1081,8 @@ void ima_update_policy(void)
>  {
>  	struct list_head *policy =3D &ima_policy_rules;
> =20
> +	/* Invalidate appraisal results before publishing appended rules. */
> +	atomic64_inc(&ima_policy_generation);
>  	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
> =20
>  	if (ima_rules !=3D (struct list_head __rcu *)policy) {
> @@ -2006,6 +2024,7 @@ ssize_t ima_parse_add_rule(char *rule)
>  				    audit_info);
>  		return result;
>  	}
> +	entry->rule_id =3D atomic64_inc_return(&ima_rule_id);
> =20
>  	list_add_tail(&entry->list, &ima_temp_rules);
> =20
>=20
> base-commit: 47324d3a5b3abd781295044d01d92d09f184e872

