Return-Path: <SRS0=BEGI=RD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93540C10F00
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 21:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6873A218B0
	for <linux-integrity@archiver.kernel.org>; Thu, 28 Feb 2019 21:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfB1V70 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:59:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfB1V70 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Feb 2019 16:59:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SLxNkl016860
        for <linux-integrity@vger.kernel.org>; Thu, 28 Feb 2019 16:59:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxqudrf7y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Feb 2019 16:59:24 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 28 Feb 2019 21:59:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 21:59:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SLxFFP59048184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 21:59:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58223A4057;
        Thu, 28 Feb 2019 21:59:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A96B0A4040;
        Thu, 28 Feb 2019 21:59:14 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 21:59:14 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Thu, 28 Feb 2019 16:59:14 -0500
In-Reply-To: <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
References: <20190226215034.68772-1-matthewgarrett@google.com>
         <20190226215034.68772-4-matthewgarrett@google.com>
         <1551369834.10911.195.camel@linux.ibm.com>
         <1551377110.10911.202.camel@linux.ibm.com>
         <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022821-0016-0000-0000-0000025C36E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022821-0017-0000-0000-000032B6A71D
Message-Id: <1551391154.10911.210.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-02-28 at 13:41 -0800, Matthew Garrett wrote:
> On Thu, Feb 28, 2019 at 10:05 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> >
> > > > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > > > index 09a5def7e28a..6a517282068d 100644
> > > > --- a/Documentation/ABI/testing/ima_policy
> > > > +++ b/Documentation/ABI/testing/ima_policy
> > > > @@ -24,7 +24,8 @@ Description:
> > > >                             [euid=] [fowner=] [fsname=] [subtype=]]
> > > >                     lsm:    [[subj_user=] [subj_role=] [subj_type=]
> > > >                              [obj_user=] [obj_role=] [obj_type=]]
> > > > -                   option: [[appraise_type=]] [permit_directio]
> > > > +                   option: [[appraise_type=] [permit_directio]
> > > > +                            [trust_vfs]]
> > >
> > > Let's generalize "trust_vfs" a bit.  How about introducing
> > > "collect_type=", with the default being reading and calculating the
> > > file hash?
> >
> > The naming might be based on the VFS name (e.g vfs_read, vfs_get_hash)
> > or on the file_operations name (eg. read, get_hash).
> 
> If collect_type=get_hash and the filesystem doesn't support the
> get_hash type, should the behaviour be to fall back to read?

"get_hash" should be limited to a specific filesystem type and
subtype.  Based on the filesystem type and subtype, couldn't a warning
be emitted at policy load time.

Mimi

