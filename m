Return-Path: <SRS0=6sc8=R7=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C1C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Mar 2019 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BF6206B6
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Mar 2019 17:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfC1RRv (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:17:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfC1RRv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Mar 2019 13:17:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SHG5HO114897
        for <linux-integrity@vger.kernel.org>; Thu, 28 Mar 2019 13:17:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rh1gvbhfk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Mar 2019 13:17:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 28 Mar 2019 17:17:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 17:17:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SHHi7E53018724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 17:17:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52182A405F;
        Thu, 28 Mar 2019 17:17:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96BCAA4060;
        Thu, 28 Mar 2019 17:17:43 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 17:17:43 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Date:   Thu, 28 Mar 2019 13:17:43 -0400
In-Reply-To: <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
         <1552945715.8658.299.camel@linux.ibm.com>
         <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
         <1552994559.4899.26.camel@linux.ibm.com>
         <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
         <1553015134.4899.82.camel@linux.ibm.com>
         <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
         <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
         <1553167318.4899.382.camel@linux.ibm.com>
         <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
         <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
         <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032817-4275-0000-0000-00000320A981
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032817-4276-0000-0000-0000382F4879
Message-Id: <1553793463.8711.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Kees]

On Fri, 2019-03-22 at 10:59 +0300, Igor Zhbanov wrote:
> On 21.03.2019 21:04, Matthew Garrett wrote:
> > On Thu, Mar 21, 2019 at 4:48 AM Igor Zhbanov <i.zhbanov@omprussia.ru> wrote:
> >> Along with disabling creating anonymous executable pages at all since
> >> is is hardly needed for the system services for normal work.
> > 
> > Is this true? Do no JIT compilers behave this way?
> 
> Well, besides JIT I've scanned all /proc/PID/maps of my web-server and didn't
> find any process with mapped anonymous executable pages.
> 
> As for JIT I suppose we could use prctl or something else to allow having
> anonymous executable pages.
> 
> I'm pondering about some system-wide (or prosses subtree-wide) default
> setting controlling whether it is allowed to have anonymous pages by default,
> and then some mechanism to turn it on/off on a per-process bases. Perhaps
> with some locking preventing reenabling after it was dropped.
> 
> And what do you think about it?

I just came across the grsecurity article on mprotect.[1]  Has anyone
looked at it?  Would it make sense to make it a minor LSM?

Mimi

[1]https://pax.grsecurity.net/docs/mprotect.txt 

