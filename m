Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:39810 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdKGRyB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 12:54:01 -0500
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Matthew Garrett <mjg59@google.com>
CC: linux-integrity <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
Date: Tue, 7 Nov 2017 18:53:48 +0100
MIME-Version: 1.0
In-Reply-To: <CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/7/2017 3:49 PM, Matthew Garrett wrote:
> On Tue, Nov 7, 2017 at 2:36 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>> Finally, digest lists address also the third issue because Linux
>> distribution vendors already provide the digests of files included in each
>> RPM package. The digest list is stored in the RPM header, signed by the
>> vendor.
> 
> RPM's hardly universal, and distributions are in the process of moving
> away from using it for distributing non-core applications (Flatpak and
> Snap are becoming increasingly popular here). I think this needs to be
> a generic solution rather than having the kernel tied to a specific
> package format.

Support for new digest list formats can be easily added. Digest list
metadata includes the digest list type, so that the appropriate parser
is selected.

I defined a new generic format for digest lists in Patch 7/15. I would
appreciate if we can discuss this format, and if you can give me
suggestions about how to improve it. I think it would not be a problem
to support your use case and associate metadata to each digest.

Digest lists should be parsed directly by the kernel, because processing
the lists in userspace would increase the chances that a compromised
tool does not upload to the kernel the expected digests. Also, digest
lists must be processed before init, otherwise appraisal will deny the
execution. Lastly, the mechanism of parsing files from the kernel is
already used to parse the IMA policy.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
