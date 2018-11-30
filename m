Return-Path: <SRS0=ZzAI=OJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2CCC04EB8
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFCB20868
	for <linux-integrity@archiver.kernel.org>; Fri, 30 Nov 2018 19:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFCB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeLAGcL (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:32:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbeLAGcK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 01:32:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUJIgPp052966
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:21:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p3avghbr6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 30 Nov 2018 14:21:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 30 Nov 2018 19:21:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Nov 2018 19:21:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAUJLkIb51052706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 19:21:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E395E11C052;
        Fri, 30 Nov 2018 19:21:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B4911C058;
        Fri, 30 Nov 2018 19:21:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.104.143])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Nov 2018 19:21:45 +0000 (GMT)
Subject: Re: [PATCH v2 5/7] ima-evm-utils: Preload OpenSSL engine via
 '--engine' option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 30 Nov 2018 14:21:34 -0500
In-Reply-To: <20181128200610.21214-5-vt@altlinux.org>
References: <20181128200610.21214-1-vt@altlinux.org>
         <20181128200610.21214-5-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18113019-0016-0000-0000-0000022F4528
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18113019-0017-0000-0000-00003287B112
Message-Id: <1543605694.4216.72.camel@linux.ibm.com>
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

> @@ -1773,6 +1776,7 @@ static char *get_password(void)
>  int main(int argc, char *argv[])
>  {
>  	int err = 0, c, lind;
> +	ENGINE *eng = NULL;
> 
>  	g_argv = argv;
>  	g_argc = argc;
> @@ -1883,6 +1887,18 @@ int main(int argc, char *argv[])
>  		case 138:
>  			measurement_list = 1;
>  			break;
> +		case 139: /* --engine e */
> +			eng = ENGINE_by_id(optarg);

The usage is only adding "--engine e" support.  Either change the
usage or add a test to verify the argument.


> +			if (!eng) {
> +				log_err("engine %s isn't available\n", optarg);
> +				ERR_print_errors_fp(stderr);
> +			} else if (!ENGINE_init(eng)) {
> +				log_err("engine %s init failed\n", optarg);
> +				ERR_print_errors_fp(stderr);
> +				ENGINE_free(eng);
> +				eng = NULL;
> +			}
> +			break;
>  		case 140: /* --xattr-user */
>  			xattr_ima = "user.ima";
>  			xattr_evm = "user.evm";

