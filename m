Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B07FC64EB4
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977C2145D
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D977C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLAGb3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:31:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbeLAGb3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 01:31:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUJIf72052918
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:21:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p3avghapt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:21:09 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 30 Nov 2018 19:21:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 19:21:06 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUJL51G4129056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 19:21:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1797A52052;
        Fri, 30 Nov 2018 19:21:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.143])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 642885204E;
        Fri, 30 Nov 2018 19:21:04 +0000 (GMT)
Subject: Re: [PATCH v2 3/7] ima-evm-utils: Define the '--xattr-user' option
 for testing
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 30 Nov 2018 14:20:53 -0500
In-Reply-To: <20181128200610.21214-3-vt@altlinux.org>
References: <20181128200610.21214-1-vt@altlinux.org>
         <20181128200610.21214-3-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18113019-0008-0000-0000-0000029B1874
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113019-0009-0000-0000-0000220569E1
Message-Id: <1543605653.4216.69.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-11-28 at 23:06 +0300, Vitaly Chikunov wrote:
> The IMA/EVM attributes are currently stored in the "security" namespace,
> which requires root privileges. Storing the ima/evm attributes in the
> "user" namespace, instead of the "security" namespace, would be useful
> for debugging and testing purposes, and because "--sigfile" does not
> work for evm signatures.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Changes since v1:
> - No code changes. Only the description is reworded.
> 
>  src/evmctl.c    | 32 ++++++++++++++++++++------------
>  src/libimaevm.c |  2 +-
>  2 files changed, 21 insertions(+), 13 deletions(-)

Missing is the manpage change, which is created based on the README.
 Perhaps it is in a later patch.

Mimi

> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index f53c684..9cbc2cb 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -145,6 +145,9 @@ static int find(const char *path, int dts, find_cb_t func);
>  struct command cmds[];
>  static void print_usage(struct command *cmd);
> 
> +static const char *xattr_ima = "security.ima";
> +static const char *xattr_evm = "security.evm";
> +
>  static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
>  {
>  	FILE *fp;
> @@ -533,7 +536,7 @@ static int sign_evm(const char *file, const char *key)
>  		dump(sig, len);
> 
>  	if (xattr) {
> -		err = lsetxattr(file, "security.evm", sig, len, 0);
> +		err = lsetxattr(file, xattr_evm, sig, len, 0);
>  		if (err < 0) {
>  			log_err("setxattr failed: %s\n", file);
>  			return err;
> @@ -572,7 +575,7 @@ static int hash_ima(const char *file)
>  		dump(hash, len);
> 
>  	if (xattr) {
> -		err = lsetxattr(file, "security.ima", hash, len, 0);
> +		err = lsetxattr(file, xattr_ima, hash, len, 0);
>  		if (err < 0) {
>  			log_err("setxattr failed: %s\n", file);
>  			return err;
> @@ -609,7 +612,7 @@ static int sign_ima(const char *file, const char *key)
>  		bin2file(file, "sig", sig, len);
> 
>  	if (xattr) {
> -		err = lsetxattr(file, "security.ima", sig, len, 0);
> +		err = lsetxattr(file, xattr_ima, sig, len, 0);
>  		if (err < 0) {
>  			log_err("setxattr failed: %s\n", file);
>  			return err;
> @@ -778,14 +781,14 @@ static int verify_evm(const char *file)
>  	if (mdlen <= 1)
>  		return mdlen;
> 
> -	len = lgetxattr(file, "security.evm", sig, sizeof(sig));
> +	len = lgetxattr(file, xattr_evm, sig, sizeof(sig));
>  	if (len < 0) {
>  		log_err("getxattr failed: %s\n", file);
>  		return len;
>  	}
> 
>  	if (sig[0] != 0x03) {
> -		log_err("security.evm has no signature\n");
> +		log_err("%s has no signature\n", xattr_evm);
>  		return -1;
>  	}
> 
> @@ -821,7 +824,7 @@ static int verify_ima(const char *file)
>  		memcpy(sig, tmp, len);
>  		free(tmp);
>  	} else {
> -		len = lgetxattr(file, "security.ima", sig, sizeof(sig));
> +		len = lgetxattr(file, xattr_ima, sig, sizeof(sig));
>  		if (len < 0) {
>  			log_err("getxattr failed: %s\n", file);
>  			return len;
> @@ -964,7 +967,7 @@ static int setxattr_ima(const char *file, char *sig_file)
>  	if (!sig)
>  		return 0;
> 
> -	err = lsetxattr(file, "security.ima", sig, len, 0);
> +	err = lsetxattr(file, xattr_ima, sig, len, 0);
>  	if (err < 0)
>  		log_err("setxattr failed: %s\n", file);
>  	free(sig);
> @@ -1162,7 +1165,7 @@ static int hmac_evm(const char *file, const char *key)
> 
>  	if (xattr) {
>  		sig[0] = EVM_XATTR_HMAC;
> -		err = lsetxattr(file, "security.evm", sig, len + 1, 0);
> +		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
>  		if (err < 0) {
>  			log_err("setxattr failed: %s\n", file);
>  			return err;
> @@ -1218,9 +1221,9 @@ static int ima_fix(const char *path)
>  		}
>  		for (; size > 0; len++, size -= len, list += len) {
>  			len = strlen(list);
> -			if (!strcmp(list, "security.ima"))
> +			if (!strcmp(list, xattr_ima))
>  				ima = 1;
> -			else if (!strcmp(list, "security.evm"))
> +			else if (!strcmp(list, xattr_evm))
>  				evm = 1;
>  		}
>  		if (ima && evm)
> @@ -1297,8 +1300,8 @@ static int cmd_ima_fix(struct command *cmd)
>  static int ima_clear(const char *path)
>  {
>  	log_info("%s\n", path);
> -	lremovexattr(path, "security.ima");
> -	lremovexattr(path, "security.evm");
> +	lremovexattr(path, xattr_ima);
> +	lremovexattr(path, xattr_evm);
> 
>  	return 0;
>  }
> @@ -1728,6 +1731,7 @@ static struct option opts[] = {
>  	{"selinux", 1, 0, 136},
>  	{"caps", 2, 0, 137},
>  	{"list", 0, 0, 138},
> +	{"xattr-user", 0, 0, 140},
>  	{}
> 
>  };
> @@ -1879,6 +1883,10 @@ int main(int argc, char *argv[])
>  		case 138:
>  			measurement_list = 1;
>  			break;
> +		case 140: /* --xattr-user */
> +			xattr_ima = "user.ima";
> +			xattr_evm = "user.evm";
> +			break;
>  		case '?':
>  			exit(1);
>  			break;
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 80b61a2..34501ca 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -595,7 +595,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
>  	int hashlen, sig_hash_algo;
> 
>  	if (sig[0] != 0x03) {
> -		log_err("security.ima has no signature\n");
> +		log_err("xattr ima has no signature\n");
>  		return -1;
>  	}
> 

