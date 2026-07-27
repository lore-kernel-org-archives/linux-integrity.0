Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954D3D47A6
	for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190923; cv=none; b=HOavObeB7oR8pdU49dQJxkars4GAeekSX6zwMObMr664Pe5xDoEG2zN57q88pQWS0fGGyhE+bPXpwzx6wbFkBxYVdScQnom3bpyAp8LJFZB9pSh5F6VGhwbygi20+AEMqkBXNH3Be+Epz+INNkg8W7ahLqzi4aQJKumdvnLz4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190923; c=relaxed/simple;
	bh=CDoRnO/TdPC9yxS0dNr0zeBls2ckjg3uZ4OOL8PjP+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJGkT6qH6N3+Np8/3lPPqDvYVSPDV0ADQtaWmjU9NsM29w2Z2r1SOHcovl+mZYKDuMZakOgICxOv61zNNtCZQ1akpO7L8Et+YUhUpxfYhbp5Ds2lwXQH1++Jqhky70tQMO1dYkKs9ps+ZzGPpR2DLZ1151BDwV6gyTn8kYWh97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J7WMRDbP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J7WMRDbP"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81f36179dd5so39997057b3.2
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2026 15:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785190920; x=1785795720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0+kWQ+nc6vciTGil9wrLfe5cbMzEt+TdtIsB94+VYM=;
        b=J7WMRDbPZqhfTaf2i4WmlRZ12S5/kqj1HRsvdreavgmCL2EYmwnphLJvgVdz+pRjLi
         W/uCMVSX9mkSA+J/b1oW3Iin6YqUiTwU4pUCw1Th/F0XYvAUo1T7ioZRKsNSgprQf0hC
         0yVEVB0mJNaCTYX0ZZ31Upok8H/HCNHs5JaXMGhJWv80WgOnNkFU1z8q3RO8fCmpPKdS
         a/XE2yhyCjMNc44DOiNMv1Ti69epZX5zx68DUnXvMUYxm/qX+sPHQ17zb8chh1XkX22F
         W6xB7bwBzl4AxinrEL/eAzJgex20FzakEWYzCXNaeJwfIUQXpfGsNvYvuPMrw9+BlLHz
         tpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190920; x=1785795720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0+kWQ+nc6vciTGil9wrLfe5cbMzEt+TdtIsB94+VYM=;
        b=bshQyS3ohWcdrbSIz8LFQAniAr3HARbzsk0gO9MC3lUyewgpFdp+OCN+4+jUxaYn9a
         oY78PdnxKgwqr9aVb89EQyS7BkEXKbIEi+JJ7ZT7y9JvmtC7wK+/LgJrmBaZgpnyjHQS
         WzzXcFBKm/avBebFgWzPEQ5VxSVw9Tc9hGNd7yV7zy6xklLDn5/SRlajxPBwQP1o4JBM
         n9hFYSnoUWxxYBLd/qZnDYp4C1uhaQZOonp0hdpTVXprLM9Y7WrOCy87UXbEOBsVT5zf
         4rK2KW8DYc8vryltA7tJXeeAfeWYk/QHaR0ee677AYgIeJTDul4QNYS3AJoXopxh3NVy
         UXgQ==
X-Gm-Message-State: AOJu0YzVoZzwrP84FMoaASKiLj24LPz+qTafpGcBMh0+YVAENkE0rZX+
	ErGHY7GIhI/zM/9pNBIq2hFba7WxNKE/mu8NysbXsfUSmxqG2zYarb7DdsxSrKqhyCc=
X-Gm-Gg: AR+sD13ROyNSKJSvskO9K9HInltTO7nxNQrmIgpgNYe3JchgklLpCCkc3SX63ZD1H7z
	l4mqTWUCPtSUj5svDEtjYhw7F8pkmReiXC+91ukv3TMdkxe1OXQ7EdKYBSz7DeR1JH6FcT36J0b
	Hr49SyPnopa/Eup1ap4GYT0OrKndhMYHBa9q1Y/y4v5sDZvFhTqPmRyb/ngW6hmjQWlY9C/RVbI
	cPHFxT8v7N4cb1FdIZOnjHuDZp9RiKloSUfolMOG/LKp8XAh2hXNiPg4JI8gekySVd4g0k+C4CA
	Q88BMKhcVaAZwH3hQULVQ9UCRhPsQ4cbRGdGuqwogcxVqVWp5ppbedkA4uZvfXBNw3cCsz2LprO
	VUaPPwRLwLY50kVrIoZS7gBRewMvQ5Ac/SWMgNFmo3DaO2sIO7yUIXbMbqu9KpwJKkBQuzgCK3b
	WKihkoyh5V5P/h2yfIlIvOQw76xNY9d0n9ftPlsrQpO+lv
X-Received: by 2002:a05:690c:4c07:b0:81e:b981:3eb5 with SMTP id 00721157ae682-81f939705ebmr6213017b3.23.1785190919658;
        Mon, 27 Jul 2026 15:21:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:7e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b02sm38756017b3.5.2026.07.27.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:21:59 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 27 Jul 2026 17:21:47 -0500
Subject: [PATCH v2 1/3] integrity: Replace all uses of
 integrity_audit_msg() with integrity_audit_message()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-report-hash-error-v2-1-30e394f524fc@cloudflare.com>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
In-Reply-To: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14589; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=CDoRnO/TdPC9yxS0dNr0zeBls2ckjg3uZ4OOL8PjP+8=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqZ9oEpT2q/ND+QHKY4ueOoUXfDhigv0f6osavj
 RqrEjjnDcyJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCamfaBAAKCRCrJbR2A5LT
 bQyXEADjW2pDv+GXvDiV3AMoMrtsQNudI0+gjVm6DiLNDHlmL5wC4973kw3lDHUfsXcH3PRxVLU
 mNcxHeY9b5rZTrsfvmhHNuYDQ6ZnQ8/RPx3/TSg/bKuvCc4DUHAXKHnWLVdsPqrnZ0vcWmYu73k
 9qHIsKjHOFLvYkX7ZJ4vogKyjLcvD6d6bLnch4MQZOJHAqbZlPsKZ6FnxWhxU11MXdZHf/ejOIT
 cxJZV4QevzBUqvemnqvdP8vql/CTZJ4+I1gBdZURzErNqo79e/m/T3KRnDI6avksZ69NUKwnKAC
 jtpdf+sm5QgOF+eUQZneOibfiUoA/e2jN91klmo9Wi8fj+nLPAS3GzoI9AeBIHu38q/Kfdg5sGR
 c09Ds+8oDyf7svOjMti5nmUEvsN3g8rTSywdwD2khdVln/Mj8/daM9kGfc82ZmRdIeqV7/wumFh
 GQd78h/bQRaHuPNxJ6eNGnaKjZQ5/tJV5v9OKUvCIMkjmqhaXUqdmkKdsNMTtdjRIoaogJLELfE
 ERhdH5kVSX//lslxW67OaOD/kh8zujXILbZoEgj2Pr9RcDAruzCrZacfDnxMrrYS2mxNsZGy1Qg
 Zkion6/9Kfppvrc+b8q4OAzLbvTsginF8rwAYi+wPi8kDfQjmhn50laNmwclzv3jrF/5fB7PB0o
 ydfXAyGkoFFZt+Q==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

integrity_audit_msg() wraps integrity_audit_message() such that
error codes are hidden by passing an additional parameter to
integrity_audit_message(). Since this is a wrapper, we can replace
this function with integrity_audit_message() introduced in commit
2f845882ecd2 ("integrity: Add errno field in audit message")

No functional change intended.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/evm/evm_main.c         | 38 ++++++++++++++++++-------------
 security/integrity/ima/ima_api.c          | 20 ++++++++--------
 security/integrity/ima/ima_appraise.c     | 12 +++++-----
 security/integrity/ima/ima_fs.c           | 11 +++++----
 security/integrity/ima/ima_init.c         |  4 ++--
 security/integrity/ima/ima_main.c         | 16 +++++++------
 security/integrity/ima/ima_policy.c       | 25 ++++++++++----------
 security/integrity/ima/ima_queue.c        |  4 ++--
 security/integrity/ima/ima_template_lib.c |  6 ++---
 9 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a89edb14d811351ec393a69de8ff7..a32c98089b055fcf84f1a33dd016a51f57693d36 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -559,11 +559,11 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 		    || dentry->d_sb->s_magic == SYSFS_MAGIC)
 			return 0;
 
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
-				    dentry->d_inode, dentry->d_name.name,
-				    "update_metadata",
-				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_METADATA,
+					dentry->d_inode, dentry->d_name.name,
+					"update_metadata",
+					integrity_status_msg[evm_status],
+					-EPERM, 0, 0);
 	}
 out:
 	/* Exception if the HMAC is not going to be calculated. */
@@ -585,10 +585,12 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 
 	if (evm_status != INTEGRITY_PASS &&
 	    evm_status != INTEGRITY_PASS_IMMUTABLE)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
-				    dentry->d_name.name, "appraise_metadata",
-				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_METADATA,
+					d_backing_inode(dentry),
+					dentry->d_name.name,
+					"appraise_metadata",
+					integrity_status_msg[evm_status],
+					-EPERM, 0, 0);
 	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
 }
 
@@ -726,10 +728,12 @@ static int evm_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		return 0;
 
 	if (evm_status != INTEGRITY_PASS_IMMUTABLE)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
-				    dentry->d_name.name, "appraise_metadata",
-				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_METADATA,
+					d_backing_inode(dentry),
+					dentry->d_name.name,
+					"appraise_metadata",
+					integrity_status_msg[evm_status],
+					-EPERM, 0, 0);
 	return -EPERM;
 }
 
@@ -990,9 +994,11 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    !evm_attr_change(idmap, dentry, attr))
 		return 0;
 
-	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
-			    dentry->d_name.name, "appraise_metadata",
-			    integrity_status_msg[evm_status], -EPERM, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_METADATA,
+				d_backing_inode(dentry), dentry->d_name.name,
+				"appraise_metadata",
+				integrity_status_msg[evm_status], -EPERM, 0,
+				0);
 	return -EPERM;
 }
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127e108dcca8ddae6575c908144859783fb6..8c37dd4c9bb805213fb62e597a70189eca12b897 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -114,9 +114,9 @@ int ima_store_template(struct ima_template_entry *entry,
 		result = ima_calc_field_array_hash(&entry->template_data[0],
 						   entry);
 		if (result < 0) {
-			integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
-					    template_name, op,
-					    audit_cause, result, 0);
+			integrity_audit_message(AUDIT_INTEGRITY_PCR, inode,
+						template_name, op, audit_cause,
+						result, 0, 0);
 			return result;
 		}
 	}
@@ -158,8 +158,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
-	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-			    op, cause, result, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_PCR, inode, filename, op,
+				cause, result, 0, 0);
 }
 
 /**
@@ -328,9 +328,9 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 		take_dentry_name_snapshot(&filename, file->f_path.dentry);
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename.name.name, "collect_data",
-				    audit_cause, result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode,
+					filename.name.name, "collect_data",
+					audit_cause, result, 0, 0);
 
 		release_dentry_name_snapshot(&filename);
 	}
@@ -382,8 +382,8 @@ void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
-		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-				    op, audit_cause, result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_PCR, inode, filename,
+					op, audit_cause, result, 0, 0);
 		return;
 	}
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 18d0d9154317b8efe9a806760f7e8eca75cca692..cc88e3add5b7028d4901e284ef920b324645e719 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -558,8 +558,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
-		integrity_audit_msg(audit_msgno, inode, filename,
-				    op, cause, rc, 0);
+		integrity_audit_message(audit_msgno, inode, filename,
+					op, cause, rc, 0, 0);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
@@ -583,8 +583,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			status = INTEGRITY_PASS;
 		}
 
-		integrity_audit_msg(audit_msgno, inode, filename,
-				    op, cause, rc, 0);
+		integrity_audit_message(audit_msgno, inode, filename,
+					op, cause, rc, 0, 0);
 	} else {
 		ima_cache_flags(iint, func);
 	}
@@ -744,8 +744,8 @@ static int validate_hash_algo(struct dentry *dentry,
 
 	path = dentry_path(dentry, pathbuf, PATH_MAX);
 
-	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
-			    "set_data", errmsg, -EACCES, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
+				"set_data", errmsg, -EACCES, 0, 0);
 
 	kfree(pathbuf);
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2a0bca5543161912abe2a0236c9fcae7055e62bc..a0c1a6dd6a750220b529cc3f77c2ae5673188e11 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -593,9 +593,10 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		result = ima_read_policy(data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-				    "policy_update", "signed policy required",
-				    1, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+					"policy_update",
+					"signed policy required",
+					result, 0, 0);
 		result = -EACCES;
 	} else {
 		ima_measure_raw_policy(data, datalen);
@@ -744,8 +745,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	}
 
 	pr_info("policy update %s\n", cause);
-	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !valid_policy, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+				"policy_update", cause, !valid_policy, 0, 0);
 
 	if (!valid_policy) {
 		ima_delete_rules();
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index d53f4d89a53e56d7ebb31950c10b37fc89782753..def350f7d6a0c58f119f2c74f26ea365471fb1c7 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -102,8 +102,8 @@ static int __init ima_add_boot_aggregate(void)
 	}
 	return 0;
 err_out:
-	integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, filename, op,
-			    audit_cause, result, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, filename, op,
+				audit_cause, result, 0, 0);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 334e21be407547cedfacce2a0b23cdb222192019..22d649fa19b334674b8e81dd537033cebf569699 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -118,8 +118,9 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
 		if (!*pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 			*pathname = ima_d_path(&file->f_path, pathbuf,
 					       filename);
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
-				    "mmap_file", "mmapped_writers", rc, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode, *pathname,
+					"mmap_file", "mmapped_writers", rc, 0,
+					0);
 	}
 	return rc;
 }
@@ -464,9 +465,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	    (allowed_algos & (1U << hash_algo)) == 0) {
 		rc = -EACCES;
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
-				    pathname, "collect_data",
-				    "denied-hash-algorithm", rc, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_DATA, file_inode(file),
+					pathname, "collect_data",
+					"denied-hash-algorithm", rc, 0, 0);
 	}
 out_locked:
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
@@ -578,8 +579,9 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 
 	file = vma->vm_file;
 	pathname = ima_d_path(&file->f_path, &pathbuf, filename);
-	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, pathname,
-			    "collect_data", "failed-mprotect", result, 0);
+	integrity_audit_message(AUDIT_INTEGRITY_DATA, inode, pathname,
+				"collect_data", "failed-mprotect", result, 0,
+				0);
 	if (pathbuf)
 		__putname(pathbuf);
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f79d07bb63c6fc4ba6fe594140de8d59f57e4f0b..4f0ebc02de4eb4cf48633f3e87362a20ece3a689 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1986,8 +1986,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	entry = kzalloc_obj(*entry);
 	if (!entry) {
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
-				    NULL, op, "-ENOMEM", -ENOMEM, audit_info);
+		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL,
+					NULL, op, "-ENOMEM", -ENOMEM,
+					audit_info, 0);
 		return -ENOMEM;
 	}
 
@@ -1996,9 +1997,9 @@ ssize_t ima_parse_add_rule(char *rule)
 	result = ima_parse_rule(p, entry);
 	if (result) {
 		ima_free_rule(entry);
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
-				    NULL, op, "invalid-policy", result,
-				    audit_info);
+		integrity_audit_message(AUDIT_INTEGRITY_STATUS, NULL,
+					NULL, op, "invalid-policy", result,
+					audit_info, 0);
 		return result;
 	}
 
@@ -2415,8 +2416,8 @@ void ima_measure_loaded_policy(void)
 
 	rule = kmalloc(rule_len, GFP_KERNEL);
 	if (!rule) {
-		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
-				    op, "ENOMEM", result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, event_name,
+					op, "ENOMEM", result, 0, 0);
 		return;
 	}
 
@@ -2433,9 +2434,9 @@ void ima_measure_loaded_policy(void)
 
 		if (seq_has_overflowed(&file)) {
 			result = -E2BIG;
-			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
-					    event_name, op, "rule_length",
-					    result, 0);
+			integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL,
+						event_name, op, "rule_length",
+						result, 0, 0);
 			rcu_read_unlock();
 			goto free_rule;
 		}
@@ -2448,8 +2449,8 @@ void ima_measure_loaded_policy(void)
 	/* copy IMA policy rules to a buffer for measuring */
 	file.buf = kmalloc(file_len, GFP_KERNEL);
 	if (!file.buf) {
-		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
-				    op, "ENOMEM", result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, event_name,
+					op, "ENOMEM", result, 0, 0);
 		goto free_rule;
 	}
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f89f0ca3d4edf16a7147b3c23d25fc2cf18044c6..e7b4df6b2ca299c38976012ac6eaaffcc5100e51 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -291,8 +291,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	}
 out:
 	mutex_unlock(&ima_extend_list_mutex);
-	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
-			    op, audit_cause, result, audit_info);
+	integrity_audit_message(AUDIT_INTEGRITY_PCR, inode, filename, op,
+				audit_cause, result, audit_info, 0);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 8a89236f926c10af0dd2b2ef08fbe59bd8a78b66..c87dcbe67820266149da6ad7d4f2f7061ff3c5c1 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -390,9 +390,9 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	    ima_hash_algo : HASH_ALGO_SHA1;
 	result = ima_calc_file_hash(event_data->file, hash_hdr);
 	if (result) {
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    event_data->filename, "collect_data",
-				    "failed", result, 0);
+		integrity_audit_message(AUDIT_INTEGRITY_DATA, inode,
+					event_data->filename, "collect_data",
+					"failed", result, 0, 0);
 		return result;
 	}
 	cur_digest = hash_hdr->digest;

-- 
2.43.0

