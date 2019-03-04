Return-Path: <SRS0=kjGR=RH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8638C43381
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Mar 2019 20:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D63120823
	for <linux-integrity@archiver.kernel.org>; Mon,  4 Mar 2019 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCDUcx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:32:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfCDUcx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Mar 2019 15:32:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24KNu7E082569
        for <linux-integrity@vger.kernel.org>; Mon, 4 Mar 2019 15:32:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r17e790bt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 04 Mar 2019 15:32:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Mar 2019 20:32:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 20:32:45 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24KWisM27721878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 20:32:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EF5A11C050;
        Mon,  4 Mar 2019 20:32:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B4711C04A;
        Mon,  4 Mar 2019 20:32:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 20:32:43 +0000 (GMT)
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided
 hashes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Date:   Mon, 04 Mar 2019 15:32:33 -0500
In-Reply-To: <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
References: <20190226215034.68772-1-matthewgarrett@google.com>
         <20190226215034.68772-4-matthewgarrett@google.com>
         <1551369834.10911.195.camel@linux.ibm.com>
         <1551377110.10911.202.camel@linux.ibm.com>
         <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
         <1551391154.10911.210.camel@linux.ibm.com>
         <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
         <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19030420-0016-0000-0000-0000025DBEE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030420-0017-0000-0000-000032B83DD6
Message-Id: <1551731553.10911.510.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-03-04 at 11:52 -0800, Matthew Garrett wrote:
> On Thu, Feb 28, 2019 at 2:38 PM Matthew Garrett <mjg59@google.com> wrote:
> >
> > On Thu, Feb 28, 2019 at 1:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Thu, 2019-02-28 at 13:41 -0800, Matthew Garrett wrote:
> > > > If collect_type=get_hash and the filesystem doesn't support the
> > > > get_hash type, should the behaviour be to fall back to read?
> > >
> > > "get_hash" should be limited to a specific filesystem type and
> > > subtype.  Based on the filesystem type and subtype, couldn't a warning
> > > be emitted at policy load time.
> >
> > The policy may be loaded before the filesystem is mounted, so even if
> > we added a capabilities mechanism we wouldn't be able to verify it.
> > There's also potentially cases where a filesystem could support hash
> > retrieval for some files but not others, and in that case we'd
> > probably want to fall back to reading the file.
> 
> To be clear, I'm entirely happy to make this change - I'd just like to
> ensure that I do it the right way!

Falling back to reading the file is fine.  So we're assuming that the
person signing a policy containing "get_hash" understands the
ramifications.  And yes, only signed policies containing "get_hash"
should be loaded.

I'd really appreciate a regression test (eg. ltp, xfstests, or
kselftests).

Mimi

