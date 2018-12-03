Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F4BC04EB9
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 13:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8359320878
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 13:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8359320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeLCNIA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:08:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbeLCNIA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Dec 2018 08:08:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3D6uVG098949
        for <linux-integrity@vger.kernel.org>; Mon, 3 Dec 2018 08:07:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p54vy0m61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 03 Dec 2018 08:06:56 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 3 Dec 2018 13:04:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 13:04:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3D47GQ55181496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 13:04:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1912342049;
        Mon,  3 Dec 2018 13:04:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70E3642042;
        Mon,  3 Dec 2018 13:04:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.63])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Dec 2018 13:04:06 +0000 (GMT)
Subject: Re: [PATCH v3 1/7] ima-evm-utils: Fix hash buffer overflow in
 verify_evm and hmac_evm
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 03 Dec 2018 08:03:55 -0500
In-Reply-To: <20181203033525.20431-1-vt@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120313-0020-0000-0000-000002F15B1C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120313-0021-0000-0000-00002140CCED
Message-Id: <1543842235.4216.221.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2018-12-03 at 06:35 +0300, Vitaly Chikunov wrote:
> Commit ae1319eeabd6 ("Remove hardcoding of SHA1 in EVM signatures")
> introduces overflow of 20 byte buffer on the stack while calculating
> hash. Also, invalid hash length is passed to the underlying verification
> function in verify_evm. This prevents any non-SHA1 hashes from being
> properly validated using evmctl.
> 
> Fixes: ae1319eeabd6 ("Remove hardcoding of SHA1 in EVM signatures")
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thank you!  This patch set has now been applied and is in master.

Mimi

> ---
> Changes since v1:
> - Fix similar issue in hmac_evm
> Changes since v2:
> - No changes.
> 
>  src/evmctl.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1b46d58..f8035da 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -55,6 +55,7 @@
>  #include <keyutils.h>
>  #include <ctype.h>
>  #include <termios.h>
> +#include <assert.h>
> 
>  #include <openssl/sha.h>
>  #include <openssl/pem.h>
> @@ -760,13 +761,15 @@ static int cmd_sign_evm(struct command *cmd)
> 
>  static int verify_evm(const char *file)
>  {
> -	unsigned char hash[20];
> +	unsigned char hash[64];
>  	unsigned char sig[1024];
> +	int mdlen;
>  	int len;
> 
> -	len = calc_evm_hash(file, hash);
> -	if (len <= 1)
> -		return len;
> +	mdlen = calc_evm_hash(file, hash);
> +	assert(mdlen <= sizeof(hash));
> +	if (mdlen <= 1)
> +		return mdlen;
> 
>  	len = lgetxattr(file, "security.evm", sig, sizeof(sig));
>  	if (len < 0) {
> @@ -779,7 +782,7 @@ static int verify_evm(const char *file)
>  		return -1;
>  	}
> 
> -	return verify_hash(file, hash, sizeof(hash), sig + 1, len - 1);
> +	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
>  }
> 
>  static int cmd_verify_evm(struct command *cmd)
> @@ -1135,11 +1138,12 @@ out:
> 
>  static int hmac_evm(const char *file, const char *key)
>  {
> -	unsigned char hash[20];
> +	unsigned char hash[64];
>  	unsigned char sig[1024];
>  	int len, err;
> 
>  	len = calc_evm_hmac(file, key, hash);
> +	assert(len <= sizeof(hash));
>  	if (len <= 1)
>  		return len;
> 

