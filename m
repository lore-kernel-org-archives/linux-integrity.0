Return-Path: <SRS0=pOO9=7U=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F22C433DF
	for <linux-integrity@archiver.kernel.org>; Sun,  7 Jun 2020 01:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35602074B
	for <linux-integrity@archiver.kernel.org>; Sun,  7 Jun 2020 01:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgFGBv7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 6 Jun 2020 21:51:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728883AbgFGBv6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Jun 2020 21:51:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0571VSlX086044;
        Sat, 6 Jun 2020 21:51:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31g42r3rar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jun 2020 21:51:56 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0571n6wU131293;
        Sat, 6 Jun 2020 21:51:56 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31g42r3rad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jun 2020 21:51:55 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0571pAWX009322;
        Sun, 7 Jun 2020 01:51:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 31g2s7rkjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Jun 2020 01:51:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0571pp2M30015578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Jun 2020 01:51:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2113A4062;
        Sun,  7 Jun 2020 01:51:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB4BA4060;
        Sun,  7 Jun 2020 01:51:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.196.163])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  7 Jun 2020 01:51:51 +0000 (GMT)
Message-ID: <1591494710.4615.49.camel@linux.ibm.com>
Subject: Re: result logged in integrity audit message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com
Date:   Sat, 06 Jun 2020 21:51:50 -0400
In-Reply-To: <4c41ce1e-3f97-5b14-8152-5411a3debb57@linux.microsoft.com>
References: <4c41ce1e-3f97-5b14-8152-5411a3debb57@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-06_20:2020-06-04,2020-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 cotscore=-2147483648 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006070005
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2020-06-05 at 20:13 -0700, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
> In integrity audit message function the inverse of "result" is being 
> logged for "res=". Please see below. Is this intentional?
> 
> void integrity_audit_msg(int audit_msgno, struct inode *inode,
> 			 const unsigned char *fname, const char *op,
> 			 const char *cause, int result, int audit_info)
> {
> 
>   ...
>   audit_log_format(ab, " res=%d", !result);
> }
> 
> The callers of this function are passing an error code (-ENOMEM, 
> -EINVAL, etc.) in the "result" parameter. But that error code is lost - 
> instead "res" is set to 0.
> 
> For example,
> 
> audit: type=1804 audit(1591411737.631:3): pid=1 uid=0 auid=4294967295 
> ses=4294967295 subj=kernel op=ima_alloc_key_entry cause=ENOMEM 
> comm="swapper/0" name=".builtin_trusted_keys" res=0

The commit message provides an explanation.  Look at b0d5de4d5880 ("IMA: fix
audit res field to indicate 1 for success and 0 for failure").

Mimi
