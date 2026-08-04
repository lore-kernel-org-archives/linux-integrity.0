Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125ED2AD37
	for <linux-integrity@vger.kernel.org>; Tue,  4 Aug 2026 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874079; cv=none; b=gwL0diB06TngYYBsELadQ3BLhj/Wt7gDt1rSRY3Bu/Z4t8NTuhFj6ythto82NVKCiu/PMo38tdwaxJaO8F8HsfUbB+2YXLk6WikIB9L92Qqhim3bPGEDatGwQXOlxOJ/JhQ2YTocsuohUrulCjNMZcP8TotG/DLUpClu4Mg0UKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874079; c=relaxed/simple;
	bh=MiqFTfuRxGdsF/z8+XrSibXCcHspsyZv91rVJRlqxWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8o9xt+sasijOP3HsIotxzeSdsVEz20Npp52lrBTlYoZ1o5zJ89GeMK4FdoOhFz52PFjF0KtnkeiszXpZkT4p1b83jxohu6EQO8sJS8t22Phku7n7ryQe0jWhy4zOb6bwi14aB0tpMja/LfocfbN61l+zGo3oOaSGCWsSYgp4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fg2YbNkH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fg2YbNkH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Jmvql1804243;
	Tue, 4 Aug 2026 20:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cB7iRUJV+achFUfwLmCRi+0nC5q0Q6T1xeBiPGQai
	1o=; b=Fg2YbNkH60cccFlZ7EtXjyaNtAtDPEQwUcP7J9HKBFY0rxPuQJgVhS60p
	2i6P2zvxWWt0FHJ5TbFqSGK5YG/ETsLsnUhobBv5LKzO4bl3Kr0uzK3lcsMABhZp
	XLUHPSiChvgYCXSXl8BjVhGevozlkfa5MBEOkUJWv4M5X6m5OiMJCGCeKopuRA04
	4NEKHkFb8lYnv45hf4inpq2CCrMnzDHsWM3PssIgB1ifXlpzzhpAqByeBSZeu6FQ
	jkM8gdqnBsh48AziYCqhZ4DAY4jKlQNgfNo988Zp9ZJUgFxXbCmBIuYkVgg4Eq7o
	ovN1Okom3+oI6BKbnnCNQGFXMq0lg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4ysbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 20:07:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674Jucbf024744;
	Tue, 4 Aug 2026 20:07:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qkqe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 20:07:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674K7dqO47907286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 20:07:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EC8220043;
	Tue,  4 Aug 2026 20:07:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D572E20040;
	Tue,  4 Aug 2026 20:07:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.135.125])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 20:07:37 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: Daniel Hodges <git@danielhodges.dev>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] evm: check return values of crypto_shash functions
Date: Tue,  4 Aug 2026 16:07:34 -0400
Message-ID: <20260804200734.2415524-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfX4qSFB3GRtDg2
 7OQ63IFbfJNGHbuZJLuvZWZOl1JHxgx6ayxYxzptyyWwkCDk8l0lS4cQX2gOKP8OZjD0JdJGChL
 FCT9a8iG2DuzsOs3F8UHKd3rtlrloNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfXysZNGSeSvCnG
 9OPCp9fF3vn03uKlmNaePvQ/VtRj25wagNTToyJcP4t1LqAGmPriTSoAPXGiItA8WXLyyP2Qfzo
 sGq12UOHxR7KUr+L4yvDgk77LVo7fQHBVeDlkSLZYDd+ept4eEzFy47sInMn9exX0WfLUjSS35F
 xUTVaRw3VUaM/+MYYbjYJ0yXt7nc2YGLhFFKrJ68Fs7bkdPZSdKIRpDmoCauT0wA+CWOtvCB54v
 c6PskTWMLoOsfTwtG/XuWQgn78IT3fZdtgONTHr/ro+3Xs8D8O0Lj8ENfF3ku0IJZ/jRx3N//6X
 0OHp6cVRIOvpv1LF1jMrpKpeNTlZCsdZa9L+q2V151IT/2HfIRgs+xsEdm0PLf5QkZ/MaOnYfQ5
 4e44QdND1cb7NwzWYGfUmHz6m549KrtCQjY7KgyHpe8XhJl0PHnd4W/oeNdchdnSYc02tVvLI0y
 UvdOziw3OyGViwO+50A==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a72468d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=pf-Wnxs_1QLkC-aiQ1wA:9
X-Proofpoint-ORIG-GUID: lqobyMoGA6m4NshzS2wFRuFG6DchFrBY
X-Proofpoint-GUID: lqobyMoGA6m4NshzS2wFRuFG6DchFrBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040160

From: Daniel Hodges <git@danielhodges.dev>

The crypto_shash_update() and crypto_shash_final() functions can fail
and return error codes, but their return values were not being checked
in several places in security/integrity/evm/evm_crypto.c:

- hmac_add_misc() ignored returns from crypto_shash_update() and
  crypto_shash_final()
- evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
- evm_init_hmac() ignored returns from crypto_shash_update()

If these hash operations fail silently, the resulting HMAC could be
invalid or incomplete, which could weaken the integrity verification
security that EVM provides.

This patch converts hmac_add_misc() from void to int return type and
adds proper error checking and propagation for all crypto_shash_*
function calls. All callers are updated to handle the new return values.
Additionally, error messages are logged when cryptographic operations
fail to provide visibility into the failure rather than silently
returning error codes.

Fixes: 66dbc325afce ("evm: re-release")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Link: https://github.com/linux-integrity/linux/issues/17
[zohar@linux.ibm.com: fixed commit 0496fc9cdc38 merge conflict,
checkpatch.pl warnings]
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Daniel, Roberto, please review this version of the patch.

 security/integrity/evm/evm_crypto.c | 67 ++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1c41af2f91a6..aef0f8f3d9d6 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -140,8 +140,8 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
  * (Additional directory/file metadata needs to be added for more complete
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
-			  char type, char *digest)
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+			 char type, char *digest)
 {
 	struct h_misc {
 		/*
@@ -156,6 +156,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 		gid_t gid;
 		umode_t mode;
 	} hmac_misc;
+	int error;

 	memset(&hmac_misc, 0, sizeof(hmac_misc));
 	/* Don't include the inode or generation number in portable
@@ -176,14 +177,30 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
-	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	error = crypto_shash_update(desc, (const u8 *)&hmac_misc,
+				    sizeof(hmac_misc));
+	if (error) {
+		pr_err("crypto_shash_update() failed: %d\n", error);
+		return error;
+	}
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
-	crypto_shash_final(desc, digest);
+	    type != EVM_XATTR_PORTABLE_DIGSIG) {
+		error = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
+					    UUID_SIZE);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			return error;
+		}
+	}
+	error = crypto_shash_final(desc, digest);
+	if (error) {
+		pr_err("crypto_shash_final() failed: %d\n", error);
+		return error;
+	}

 	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
 		 (int)sizeof(struct h_misc), &hmac_misc);
+	return 0;
 }

 /*
@@ -267,9 +284,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,

 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(xattr->name, req_xattr_name)) {
-			error = 0;
-			crypto_shash_update(desc, (const u8 *)req_xattr_value,
-					     req_xattr_value_len);
+			error = crypto_shash_update(desc,
+						    (const u8 *)req_xattr_value,
+						    req_xattr_value_len);
+			if (error) {
+				pr_err("crypto_shash_update() failed: %d\n",
+				       error);
+				goto out;
+			}
 			if (is_ima)
 				ima_present = true;

@@ -293,15 +315,21 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
 				 dentry->d_name.name, xattr->name, size,
 				 user_space_size);
-		error = 0;
 		xattr_size = size;
-		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		error = crypto_shash_update(desc, (const u8 *)xattr_value,
+					    xattr_size);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			goto out;
+		}
 		if (is_ima)
 			ima_present = true;

 		dump_security_xattr(xattr->name, xattr_value, xattr_size);
 	}
-	hmac_add_misc(desc, inode, type, data->digest);
+	error = hmac_add_misc(desc, inode, type, data->digest);
+	if (error)
+		goto out;

 	if (inode != d_backing_inode(dentry) && iint) {
 		if (IS_I_VERSION(inode))
@@ -409,6 +437,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 	struct shash_desc *desc;
 	const struct xattr *xattr;
 	struct xattr_list *xattr_entry;
+	int error;

 	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
@@ -423,14 +452,20 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 				   XATTR_SECURITY_PREFIX_LEN, xattr->name) != 0)
 				continue;

-			crypto_shash_update(desc, xattr->value,
-					    xattr->value_len);
+			error = crypto_shash_update(desc, xattr->value,
+						    xattr->value_len);
+			if (error) {
+				pr_err("crypto_shash_update() failed: %d\n",
+				       error);
+				goto out;
+			}
 		}
 	}

-	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+	error = hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+out:
 	kfree(desc);
-	return 0;
+	return error;
 }

 /*
--
2.55.0

