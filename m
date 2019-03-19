Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FDC43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCE520700
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCSRGx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:06:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbfCSRGx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Mar 2019 13:06:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JH6i0v005904
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2019 13:06:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb3wx1wxt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2019 13:06:49 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 19 Mar 2019 17:05:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 17:05:33 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JH5ZVi59375796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 17:05:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA8C34C044;
        Tue, 19 Mar 2019 17:05:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CD024C040;
        Tue, 19 Mar 2019 17:05:34 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 17:05:34 +0000 (GMT)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-integrity@vger.kernel.org
Date:   Tue, 19 Mar 2019 13:05:34 -0400
In-Reply-To: <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
         <1552945715.8658.299.camel@linux.ibm.com>
         <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
         <1552994559.4899.26.camel@linux.ibm.com>
         <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031917-0012-0000-0000-00000304CDE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031917-0013-0000-0000-0000213BDDF6
Message-Id: <1553015134.4899.82.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=62 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-03-19 at 15:19 +0300, Igor Zhbanov wrote:
> On 19.03.2019 14:22, Mimi Zohar wrote:
> > On Tue, 2019-03-19 at 10:50 +0300, Igor Zhbanov wrote:
> >> Hi Mimi,
> >>
> >> I guess similar to SELinux function:
> > [snip]
> > 
> > Remember IMA relies on LSMs for mandatory access control(MAC).  IMA
> > measures, audits, and enforces file integrity.
> 
> Yes. But LSM will not check integrity of the file mmaped for read. Nor does
> IMA.
> 

Ok, so we can start there and modify the existing ima_file_mmap() to
verify file signatures that are being mmap'ed read.  The question will
then become what to do with mprotect write and execute.

> >> The structure vm_area_struct has a pointer vm_file pointing to mapped file
> >> so it could be used what file's xattrs to check.
> > 
> > That's fine for when there is a file descriptor, but the file
> > descriptor could have been closed.  (Refer to the mmap manpage.)
> 
> Can it be checked?
> 
> I think that checking the integrity at least in the case when the file is
> still open is better than not checking at all. Because as I said it would
> be possible to use mmap+mprotect to bypass IMA for shared libraries checking.

And what would you do with the mprotect without a file descriptor?

The mmap signature verification status is cached in the iint, based on
the inode.  I think whatever solution will need to be able to access
this cached information.

Mimi

