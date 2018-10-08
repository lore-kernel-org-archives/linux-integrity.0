Return-Path: <SRS0=CrZS=MU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7A4C67879
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD5B21476
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 22:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD5B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJIFyp (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:54:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbeJIFyp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 01:54:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98MY9aH005288
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 18:40:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n0cefyvqj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 18:40:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 23:40:37 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 23:40:35 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w98MeYu958785926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 22:40:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8316342047;
        Tue,  9 Oct 2018 01:40:11 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4494203F;
        Tue,  9 Oct 2018 01:40:10 +0100 (BST)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Oct 2018 01:40:10 +0100 (BST)
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 08 Oct 2018 18:40:32 -0400
In-Reply-To: <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
         <1538997900.15382.90.camel@linux.ibm.com>
         <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100822-4275-0000-0000-000002C6C02B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100822-4276-0000-0000-000037D1E7E6
Message-Id: <1539038432.15382.181.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=902 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080212
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181008224032.4eeAUtXwB4PA9yoUjXAA3Oftg4FfkmpISM-2Xx5KiqI@z>

On Mon, 2018-10-08 at 13:19 -0700, Matthew Garrett wrote:
> On Mon, Oct 8, 2018 at 4:25 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Fri, 2018-10-05 at 12:25 -0700, Matthew Garrett wrote:

> > > I agree that using FUSE in general is incompatible with IMA's goals,
> > > but it's possible to configure systems where you can ensure that only
> > > trustworthy code is involved. In that scenario this patch improves
> > > performance without compromising security.
> >
> > If you trust a FUSE filesystem to not only behave properly, but also
> > to return file hashes, what is the value of measuring/appraising the
> > files?  Define a custom policy that doesn't measure/appraise files on
> > FUSE filesystems.
> 
> We trust that the filesystem will return us accurate binaries and
> hashes, but we don't the binaries themselves may not be trustworthy -
> we want the same level of audit trail associated with their execution
> that we'd have for something run off local disk. We could certainly
> rearchitect our filesystems to generate audit events themselves, but
> we'd be duplicating functionality that already exists in the kernel.

I'm really not comfortable with the FUSE filesystem calculating the
file hash being used by IMA.  Adding FUSE i_version support would have
been better, instead of returning the actual file hash.  Based on a
mount option and the i_version, the kernel could then decide whether
or not to limit re-calculating the file hash.

Mimi

